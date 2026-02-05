import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key, required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(taskModel.title??''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskModel.description??''),
            Text('Date : ${taskModel.createdDate}',style: TextStyle(
                color:Colors.black,
                fontWeight: FontWeight.w600
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text(taskModel.status?? "New",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                ),
                  backgroundColor: Colors.lightBlue,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                ),
                ButtonBar(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                  ],

                )
              ],

            )
          ],

        ),
      ),
    );
  }
}