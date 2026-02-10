
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  bool _resetPasswordScreenInProgress = false;

  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                        "Set Password",
                        style: Theme.of(context).textTheme.titleLarge
                    ),
                    Text(
                        "Give Minimum 6 digit password.password should be combination of letters and numbers",
                        style: Theme.of(context).textTheme.titleSmall
                    ),

                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(
                        hintText: "Password"
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      decoration: InputDecoration(
                          hintText: "Confirm Password"
                      ),
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: _resetPasswordScreenInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(onPressed: _onTapConfirmButton,
                          child:Text("Confirm"),
                      ),
                    ),

                    const SizedBox(height: 34,),
                    Center(
                      child: RichText(text: TextSpan(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                        text:"Have account? ",
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: const TextStyle(
                              color: AppColors.themeColor
                            ),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              _onTapSignInButton();
                            }
                          )

                        ]

                       )
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

  void _onTapSignInButton(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=>SignInScreen()), (route)=>false);

  }
  void _onTapConfirmButton(){
    _resetPassword();
  }
  Future<void> _resetPassword() async {
    _resetPasswordScreenInProgress = true;
    if (mounted) setState(() {});

    Map<String, dynamic> requestInput = {
      "email": widget.email,
      "OTP":widget.otp,
      "password": _passwordTEController.text,

    };

    NetworkResponse response =
    await NetworkCaller.postRequest(Urls.registration, body: requestInput);

    _resetPasswordScreenInProgress = false;
    if (mounted) setState(() {});

    if (response.isSuccess) {
      _clearTextFields();
      if (mounted) {
        showSnackBarMessage(context, 'Password Reset Successful');
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),),);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Password Reset Failed! Try Again.');
      }
    }
  }

  /// Clears all text fields after successful registration
  void _clearTextFields() {
    _confirmPasswordTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}


