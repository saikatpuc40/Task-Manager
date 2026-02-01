import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/in_progress_task_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/network_cached_image.dart';

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
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(),
      body: _screens[_selectedIndex],
       bottomNavigationBar: BottomNavigationBar(
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
           items: const [
             BottomNavigationBarItem(icon: Icon(Icons.abc), label: "New Task"),
             BottomNavigationBarItem(icon: Icon(Icons.done), label: "Completed"),
             BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "In Progress"),
             BottomNavigationBarItem(icon: Icon(Icons.close), label: "Cancelled"),
           ]
       ),
    );
  }
}
AppBar profileAppBar() {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading:  Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        child: NetworkCachedImage(url: ''),
      ),
    ),
    title: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Saikat",
          style: TextStyle(
              fontSize: 16,
              color: Colors.white
          ),
        ),
        Text("saikat@gmail.com",
          style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500
          ),)
      ],
    ),
    actions: [
      IconButton(onPressed: (){}, icon: const Icon(Icons.logout))
    ],
  );
}
