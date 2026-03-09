import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/sign_up_controller.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/utilities/app_constants.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

/// ---------------------------------------------------------------------------
/// SignUpScreen
/// ---------------------------------------------------------------------------
/// This screen allows new users to register for the Task Manager application.
///
/// Responsibilities:
/// - Collect user information: email, first name, last name, mobile, password
/// - Validate user input before submission
/// - Show/hide password functionality
/// - Display loading indicator while registration is in progress
/// - Call the registration API and handle responses via NetworkCaller
/// - Display success or error messages to the user
/// - Provide navigation link to Sign In screen for existing users
///
/// Important Notes:
/// - The form uses Flutter's `Form` and `TextFormField` widgets with validators.
/// - API responses should ONLY be handled through `NetworkResponse.isSuccess`.
/// - UI should not directly handle HTTP status codes.
/// - The screen uses a custom `BackgroundWidget` for consistent app styling.
/// ---------------------------------------------------------------------------

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  SignUpController signUpController = Get.find<SignUpController>();
  // -------------------------------------------------------------------------
  // Text Controllers
  // -------------------------------------------------------------------------
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();

  // -------------------------------------------------------------------------
  // Form Key
  // -------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // -------------------------------------------------------------------------
  // UI State
  // -------------------------------------------------------------------------
  bool _showPassword = false;

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

                    // Page Title
                    Text(
                      "join_with_us".tr,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),

                    // Email Input
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:  InputDecoration(
                        hintText: "email".tr,
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'enter_email'.tr;
                        }
                        if (!AppConstants.emailRegExp.hasMatch(value!)) {
                          return 'enter_valid_email'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    // First Name Input
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: InputDecoration(
                        hintText: "first_name".tr,
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'enter_your_first_name'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    // Last Name Input
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: InputDecoration(
                        hintText: "last_name".tr,
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'enter_your_last_name'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    // Mobile Input
                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "mobile".tr,
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'enter_mobile'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    // Password Input with show/hide functionality
                    TextFormField(
                      obscureText: !_showPassword,
                      controller: _passwordTEController,
                      decoration: InputDecoration(
                        hintText: "password".tr,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _showPassword = !_showPassword;
                            if (mounted) setState(() {});
                          },
                          icon: Icon(
                            _showPassword
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'enter_password'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Registration Button or Loading Indicator
                    GetBuilder<SignUpController>(
                      builder: (_) {
                        return Visibility(
                          visible: signUpController.registrationInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _registerUser();
                              },
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      }
                    ),

                    const SizedBox(height: 34),

                    // Navigate to Sign In Screen
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                          ),
                          text: "have_account".tr,
                          children: [
                            TextSpan(
                              text: 'sign_in'.tr,
                              style: const TextStyle(color: AppColors.themeColor),
                              recognizer:
                              TapGestureRecognizer()..onTap = _onTapSignInButton,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final bool result = await signUpController.registerUser(
          _emailTEController.text.trim(),
          _firstNameTEController.text.trim(),
          _lastNameTEController.text.trim(),
          _mobileTEController.text.trim(),
          _passwordTEController.text
      );
      _clearTextFields();
      if(result){
        if(mounted){
          showSnackBarMessage(context, "registration_success".tr);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()),);
        }
      }
      else{
        if(mounted){
          showSnackBarMessage(context, signUpController.errorMessage);
        }
      }


    }
  }


  /// Clears all text fields after successful registration
  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  /// Navigates back to the Sign In screen
  void _onTapSignInButton() {
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
