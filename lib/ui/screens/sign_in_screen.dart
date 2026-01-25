
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
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
                        "Get Started With",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(
                        hintText: "Email"
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(
                          hintText: "Password"
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: (){},
                        child:Icon(Icons.arrow_circle_right_outlined),
                    ),

                    const SizedBox(height: 34,),
                    Center(
                      child: Column(
                        children: [
                          TextButton(onPressed: (){},
                              child: Text("Forgot Password?")
                          ),
                          RichText(text: TextSpan(
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.4,
                            ),
                            text:"Don't hava an account? ",
                            children: [
                              TextSpan(
                                text: 'Sign up',
                                style: const TextStyle(
                                  color: AppColors.themeColor
                                ),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  //Navigator.pushNamed(context, '/signup');
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
          )
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


