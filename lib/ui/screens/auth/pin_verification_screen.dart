
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/auth/reset_password_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;
  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  NetworkCaller networkCaller = Get.find<NetworkCaller>();

  bool _pinVerificationScreenInProgress = false;

  final TextEditingController _verificationPinTEController = TextEditingController();
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
                        "Pin Verification",
                        style: Theme.of(context).textTheme.titleLarge
                    ),
                    Text(
                        "A 6 digit verification pin has been send your email address",
                        style: Theme.of(context).textTheme.titleSmall
                    ),
                    const SizedBox(height: 24),
                    _buildPinCodeTextField(),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: _pinVerificationScreenInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(onPressed: _onTapVerifyButton,
                          child:Text("Verify"),
                      ),
                    ),
                    const SizedBox(height: 34,),
                    _buildOnTapSignupButton()
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

  Widget _buildOnTapSignupButton() {
    return Center(
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
                  );
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: AppColors.themeColor,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    controller: _verificationPinTEController,
                    appContext: context,
                  );
  }

  void _onTapVerifyButton(){
    _emailVerification();
  }

  void _onTapSignInButton(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen(),
        ), (route) => false);

  }
  Future<void> _emailVerification() async {
    _pinVerificationScreenInProgress = true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await networkCaller.getRequest(Urls.verifyPinTask(widget.email, _verificationPinTEController.text.trim()));
    _pinVerificationScreenInProgress = false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      _clearTextFields();
      if(mounted){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>ResetPasswordScreen(
            email: widget.email,
            otp: _verificationPinTEController.text.trim(),
          ),
          ),
        );

      }
    }
    else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage?? 'Pin Verification Failed!');
      }
    }


  }

  void _clearTextFields(){
    _verificationPinTEController.clear();
  }

  @override
  void dispose() {
    _verificationPinTEController.dispose();
    super.dispose();
  }
}


