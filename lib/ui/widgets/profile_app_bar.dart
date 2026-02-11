
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/auth_controllers.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
//import 'package:task_manager/ui/widgets/network_cached_image.dart';

AppBar profileAppBar(context,[bool isUpdateProfile = false]) {

  AuthControllers authControllers = Get.find<AuthControllers>();
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading:  Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        //child: NetworkCachedImage(url: ''),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.memory(base64Decode(authControllers.userData?.photo??''),
          ),
        ),
      ),
    ),
    title: GestureDetector(
      onTap: (){
        if(isUpdateProfile){
          return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileScreen()
        )
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(authControllers.userData?.fullName ?? '',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white
            ),
          ),
          Text(authControllers.userData?.email ?? '',
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500
            ),)
        ],
      ),
    ),
    actions: [
      IconButton(onPressed: () async {
        await authControllers.clearAllData();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()),
              (route)=>false,
        );
      }, icon: const Icon(Icons.logout))
    ],
  );
}