
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/email_verification_controller.dart';
import 'package:task_manager/ui/screens/auth/pin_verification_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {


  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EmailVerificationController emailVerificationController = Get.find<EmailVerificationController>();

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
                          "Your Email Address",
                          style: Theme.of(context).textTheme.titleLarge
                      ),
                      Text(
                          "A 6 digit verification pin will send your email address",
                          style: Theme.of(context).textTheme.titleSmall
                      ),

                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value){
                          if(value?.trim().isEmpty??true){
                            return 'Enter your Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email"
                        ),
                      ),
                      const SizedBox(height: 16),
                      GetBuilder<EmailVerificationController>(
                        builder: (_) {
                          return Visibility(
                            visible: emailVerificationController.emailVerificationScreenInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(onPressed: _onTapConfirmEmailButton,
                                child:Icon(Icons.arrow_circle_right_outlined),
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
    Navigator.pop(context);

  }

  Future<void> _onTapConfirmEmailButton() async {
    if(_formKey.currentState!.validate()){
      final bool result = await emailVerificationController.emailVerification(
          _emailTEController.text.trim(),
      );
      if(result){
        _clearTextFields();
        if(mounted){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => PinVerificationScreen(
                email:_emailTEController.text.trim()
            ),
          ),);
        }
      }
      else{
        if(mounted){
          showSnackBarMessage(context, emailVerificationController.errorMessage);
        }
      }
    }
  }


  void _clearTextFields(){
    _emailTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}


