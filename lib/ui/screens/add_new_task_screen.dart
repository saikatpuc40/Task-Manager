import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/task_controller.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/profile_app_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  TaskController taskController = Get.find<TaskController>();

  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(
                      hintText: 'title'.tr
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'enter_title'.tr;
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "description".tr
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'enter_description'.tr;
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 16,),
                  GetBuilder<TaskController>(
                    builder: (_) {
                      return Visibility(
                        visible: taskController.isLoading==false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(onPressed: (){
                          _newTaskAddButton();
                          }, child: Text("add".tr)),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 Future<void> _newTaskAddButton() async {
   if(_formKey.currentState!.validate()){
     final bool result = await taskController.addTask(_titleTEController.text.trim(), _descriptionTEController.text.trim());
     if(result){
       _clearTextFields();
       if(mounted){
         showSnackBarMessage(context, "task_added_success".tr);
       }
     }
     else{
       if(mounted){
         showSnackBarMessage(context, taskController.errorMessage??"task_add_failed".tr);
       }
     }

   }

 }

  void _clearTextFields(){
    _titleTEController.clear();
    _descriptionTEController.clear();
  }



  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
