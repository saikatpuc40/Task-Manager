import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/in_progress_task_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/profile_app_bar.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  bool _completedTaskInProgress= false;

  int _selectedIndex=0;
  final List<Widget> _screens= const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: _screens[_selectedIndex],
       bottomNavigationBar: BottomNavigationBar(
           currentIndex: _selectedIndex,
           onTap: (index){
             _selectedIndex=index;
             if(mounted){
               setState(() {});
             }
             _completedTask();
           },
           selectedItemColor: AppColors.themeColor,
           unselectedItemColor: Colors.grey,
           showUnselectedLabels: true,
           items: const [
             BottomNavigationBarItem(icon: Icon(Icons.abc),  label: "New Task"),
             BottomNavigationBarItem(icon: Icon(Icons.done), label: "Completed"),
             BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "In Progress"),
             BottomNavigationBarItem(icon: Icon(Icons.close), label: "Cancelled"),
           ]
       ),
    );
  }

  Future<void> _completedTask() async {
    _completedTaskInProgress =true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTask(widget.taskModel.sId!, dropdownValue));
    if(response.isSuccess){

    }
    else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage?? 'Task Completed Failed!');
      }
    }
    _completedTaskInProgress = false;
    if(mounted){
      setState(() {});
    }
  }
}



