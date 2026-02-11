
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/sign_in_controllers.dart';
import 'package:task_manager/ui/screens/auth/email_verification_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/utilities/app_constants.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'Package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  final SignInControllers signInControllers = Get.find<SignInControllers>();


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
                          "Get Started With",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailTEController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email"
                        ),
                        validator: (String? value){
                          if(value?.trim().isEmpty??true){
                            return 'Enter your Email';
                          }
                          if(AppConstants.emailRegExp.hasMatch(value!)==false){
                            return 'Enter valid Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordTEController,
                        obscureText: _showPassword == false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: IconButton(
                                onPressed: (){
                                  _showPassword=!_showPassword;
                                  if(mounted){
                                    setState(() {});
                                  }
                                },
                                icon: Icon(_showPassword?Icons.visibility:Icons.visibility_off))
                        ),
                        validator: (String? value){
                          if(value?.isEmpty??true){
                            return 'Enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      GetBuilder<SignInControllers>(
                        builder: (_) {
                          return Visibility(
                            visible: signInControllers.signInApiInProgress==false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed:  _onTapArrowIconButton,
                              child:Icon(Icons.arrow_circle_right_outlined),

                            ),
                          );
                        }
                      ),

                      const SizedBox(height: 34,),
                      Center(
                        child: Column(
                          children: [
                            TextButton(onPressed: (){
                              _onTapForgotPasswordButton();
                            },
                                child: Text("Forgot Password?")
                            ),
                            RichText(text: TextSpan(
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                              text:"Don't have an account? ",
                              children: [
                                TextSpan(
                                  text: 'Sign up',
                                  style: const TextStyle(
                                    color: AppColors.themeColor
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    _onTapSignUpButton();
                                  }
                                )

                              ]

                             )
                            ),
                          ],
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

  Future<void> _onTapArrowIconButton() async {
    if(_formKey.currentState!.validate()){
      final bool result = await signInControllers.signIn(
          _emailTEController.text.trim(),
          _passwordTEController.text,
      );
      if(result){
        Get.offAll(()=>const MainBottomNavScreen());
      }
      else{
        if(mounted){
          showSnackBarMessage(context, signInControllers.errorMessage);
        }
      }
    }
  }
  void _onTapSignUpButton(){
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );

  }

  void _onTapForgotPasswordButton(){
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => EmailVerificationScreen()
      ),
    );

  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }
}


