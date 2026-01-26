
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  final TextEditingController _emailTEController = TextEditingController();
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
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email"
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: (){},
                        child:Text("Verify"),
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
    Navigator.pop(context);

  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}


