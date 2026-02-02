import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/profile_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48,),
                  Text("Update Profile", style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge),
                  const SizedBox(height: 16),
                  _buildPhotoPickerWidget(),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      hintText: "Email"
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: InputDecoration(
                        hintText: "First Name"
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: InputDecoration(
                        hintText: "Last Name"
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _mobileTEController,
                    decoration: InputDecoration(
                        hintText: "Mobile"
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
                  ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
                  const SizedBox(height: 16,)
                ],
              ),
            ),
          ),
        ),
      ),
    );


  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }


  Widget _buildPhotoPickerWidget() {
    return Container(
              width: double.maxFinite,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                width: 100,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)
                  )
                ),
                alignment: Alignment.center,
                child: Text("Photo",style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16
                ),),

              ),
            );
  }
}
