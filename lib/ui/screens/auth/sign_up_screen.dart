
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/utilities/app_constants.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  bool _registrationInProgress = false;

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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      Text(
                          "Join With Us",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email"
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty??true) {
                            return 'Enter you Email';
                          }
                          if(AppConstants.emailRegExp.hasMatch(value!)==false){
                            return 'Enter valid Email';
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _firstNameTEController,
                        decoration: InputDecoration(
                            hintText: "First Name"
                        ),
                        validator: (String?value){
                          if(value?.trim().isEmpty??true){
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _lastNameTEController,
                        decoration: InputDecoration(
                            hintText: "Last Name"
                        ),
                        validator: (String?value){
                          if(value?.trim().isEmpty??true){
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _mobileTEController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Mobile"
                        ),
                        validator: (String?value){
                          if(value?.trim().isEmpty??true){
                            return 'Enter your Mobile';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: _showPassword == false,
                        controller: _passwordTEController,
                        decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: IconButton(
                                onPressed: (){
                                  _showPassword = !_showPassword;
                                  if(mounted){
                                    setState(() {});
                                  }
                                },
                                icon: Icon(_showPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off))
                        ),
                        validator: (String?value){
                          if(value?.isEmpty??true){
                            return 'Enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Visibility(
                        visible: _registrationInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(onPressed: (){
                          if(_formKey.currentState!.validate()){
                            _registerUser();
                          }
                        },
                            child:Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),

                      const SizedBox(height: 34,),
                      Center(
                        child:
                        RichText(text: TextSpan(
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
                              recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
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

  Future<void> _registerUser() async {
    _registrationInProgress = true;
    if(mounted){
      setState(() {});
    }
    Map<String, dynamic> requestInput = {
      "email":_emailTEController.text.trim(),
      "firstName":_firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text.trim(),
      "mobile":_mobileTEController.text.trim(),
      "password":_passwordTEController.text.trim(),
      "photo":""
    };

    NetworkResponse response =  await NetworkCaller.postRequest(Urls.registration,body: requestInput);
    _registrationInProgress = false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      _clearTextFields();
      if(mounted){
        showSnackBarMessage(context, 'Registration Successful');
      }
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage?? 'Registration Failed!.Try Again.');
      }
    }
  }

  void _clearTextFields(){
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignInButton(){
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }
}


