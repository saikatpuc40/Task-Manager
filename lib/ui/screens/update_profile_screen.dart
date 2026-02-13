import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/controllers/auth_controllers.dart';
import 'package:task_manager/ui/controllers/update_profile_controller.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/profile_app_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  NetworkCaller networkCaller = Get.find<NetworkCaller>();
  AuthControllers authControllers = Get.find<AuthControllers>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  UpdateProfileController updateProfileController= Get.find<UpdateProfileController>();

  @override
  void initState() {
    super.initState();
    final userData = authControllers.userData!;
    _emailTEController.text =userData.email ?? " ";
    _firstNameTEController.text =userData.firstName ?? " ";
    _lastNameTEController.text =userData.lastName ?? " ";
    _mobileTEController.text =userData.mobile ?? " ";
  }

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
                    enabled: false,
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
                  GetBuilder<UpdateProfileController>(
                    builder: (_) {
                      return Visibility(
                        visible: updateProfileController.updateProfileInProgress==false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                          child: ElevatedButton(onPressed: (){
                            _updateProfile();
                          }, child: Icon(Icons.arrow_circle_right_outlined)));
                    }
                  ),
                  const SizedBox(height: 16,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _updateProfile() async {
    if(_formKey.currentState!.validate()){
      final bool result = await updateProfileController.updateProfile(_emailTEController.text.trim(), _firstNameTEController.text.trim(), _lastNameTEController.text.trim(), _mobileTEController.text.trim(), _passwordTEController.text);
      if(result){
        if(mounted){
          showSnackBarMessage(context, "Profile Updated Successfully");
        }
      }
      else{
        if(mounted){
          showSnackBarMessage(context, updateProfileController.errorMessage);
        }
      }
    }

    }
  Widget _buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: updateProfileController.pickProfileImage,
      child: Container(
                width: double.maxFinite,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
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
                    const SizedBox( width: 16,),
                    Expanded(
                      child: Text(
                        _selectedImage?.name ?? 'No Image Selected',
                        maxLines: 1,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ))

                  ],
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


}
