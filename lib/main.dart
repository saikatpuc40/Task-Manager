import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:task_manager/ui/controllers/language_controller.dart';
import 'package:get/get.dart';

void main() async {
  // runApp(
  //       const TaskManagerApp(), // Wrap your app
  // );
  WidgetsFlutterBinding.ensureInitialized();
  final languageController = Get.put(LanguageController());
  await languageController.loadLanguage();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => TaskManagerApp(), // Wrap your app
    ),
  );
}

