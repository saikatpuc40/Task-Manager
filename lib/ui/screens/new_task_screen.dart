
import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item.dart';



class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
        child: Column(
          children: [
            _buildSummarySection(),
            const SizedBox(height: 8,),
            Expanded(child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TaskItem();

                },
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildSummarySection() {
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TaskSummaryCard(
                title: "New Task",
                count: "12",
              ),
              TaskSummaryCard(
                title: "Completed",
                count: "12",
              ),
              TaskSummaryCard(
                title: "In Progress",
                count: "12",
              ),
              TaskSummaryCard(
                title: "Cancelled",
                count: "12",
              ),
            ],
          ),
        );
  }

}




