
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/controllers/reset_password_controller.dart';
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
  NetworkCaller networkCaller = Get.find<NetworkCaller>();

  ResetPasswordController resetPasswordController = Get.find<ResetPasswordController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                child: Form(
                  key: _formKey,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String?value){
                          if(value?.isEmpty??true){
                            return 'Enter your password';
                          }
                          return null;
                        }
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _confirmPasswordTEController,
                        decoration: InputDecoration(
                            hintText: "Confirm Password"
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String?value){
                          if(value?.isEmpty??true){
                            return 'Enter your Confirm password';
                          }
                          return null;
                        }
                      ),
                      const SizedBox(height: 16),
                      GetBuilder<ResetPasswordController>(
                        builder: (_) {
                          return Visibility(
                            visible: resetPasswordController.resetPasswordScreenInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(onPressed: _onTapConfirmButton,
                                child:Text("Confirm"),
                            ),
                          );
                        }
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
  Future<void> _onTapConfirmButton() async {
    if(_formKey.currentState!.validate()){
      final bool result = await resetPasswordController.resetPassword(widget.email, widget.otp, _passwordTEController.text);
      _clearTextFields();
      if(result){
        if(mounted){
          showSnackBarMessage(context, "Password Reset Successful");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
        }
      }
      else{
        if(mounted){
          showSnackBarMessage(context, resetPasswordController.errorMessage);
        }
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


