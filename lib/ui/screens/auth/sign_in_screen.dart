
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/controllers/auth_controllers.dart';
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

  bool _SignInApiInProgress = false;


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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            hintText: "Password"
                        ),
                        validator: (String? value){
                          if(value?.isEmpty??true){
                            return 'Enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Visibility(
                        visible: _SignInApiInProgress==false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed:  _onTapArrowIconButton,
                          child:Icon(Icons.arrow_circle_right_outlined),

                        ),
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

  void _onTapArrowIconButton(){
    if(_formKey.currentState!.validate()){
      _signIn();
    }
  }

  Future<void> _signIn() async {
    _SignInApiInProgress = true;
    if(mounted){
      setState(() {});
    }
    Map<String,dynamic> requestData={
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(Urls.login,body: requestData);
    _SignInApiInProgress = false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthControllers.saveUserAccessToken(loginModel.token!);
      await AuthControllers.saveUserData(loginModel.userModel!);
      if(mounted){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context)=>MainBottomNavScreen(),
          ),
        );

      }
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage??'Invalid Credentials!');
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


