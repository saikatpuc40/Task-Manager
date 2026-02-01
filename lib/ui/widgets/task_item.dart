import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text("Title Will Be Here"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description Will be here"),
            Text('Date : 12/10/2026',style: TextStyle(
                color:Colors.black,
                fontWeight: FontWeight.w600
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text("New",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(
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