
import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/profile_app_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(),
      body:Column(
        children: [
          Row(
            children: [
              Card(
                child: Column(
                  children: [
                    Text("12"),
                    Text("New Task")
                  ],
                ),
              )
            ],
          )
        ],
      )
    );
  }

}
