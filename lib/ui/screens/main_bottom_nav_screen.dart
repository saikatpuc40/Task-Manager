import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/in_progress_task_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/settings_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/profile_app_bar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex=0;
  final List<Widget> _screens= const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
    SettingsScreen(),
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: _screens[_selectedIndex],
       bottomNavigationBar: BottomNavigationBar(
           type: BottomNavigationBarType.fixed,
           currentIndex: _selectedIndex,
           onTap: (index){
             _selectedIndex=index;
             if(mounted){
               setState(() {});
             }
           },
           selectedItemColor: AppColors.themeColor,
           unselectedItemColor: Colors.grey,
           showUnselectedLabels: true,
           items:  [
             BottomNavigationBarItem(icon: Icon(Icons.abc), label: "new_task".tr),
             BottomNavigationBarItem(icon: Icon(Icons.done), label: "completed".tr),
             BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "in_progress".tr),
             BottomNavigationBarItem(icon: Icon(Icons.close), label: "cancelled".tr),
             BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings".tr),
           ]
       ),
    );
  }
}



