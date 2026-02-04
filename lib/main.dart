import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:device_preview/device_preview.dart';

void main(){
  runApp(
        const TaskManagerApp(), // Wrap your app
  );
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => TaskManagerApp(), // Wrap your app
  //   ),
  // );
}

