import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/language_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 6,
            child: ListTile(
              leading: Icon(Icons.mode),
              title: Text("change_mode".tr),
              onTap: (){
                Get.bottomSheet(
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.light_mode),
                          title: Text("light_mode".tr),
                          onTap: (){
                            Get.changeThemeMode(ThemeMode.light);
                            Get.back();
                          }
                        ),
                        ListTile(
                          leading: Icon(Icons.dark_mode),
                          title: Text("dark_mode".tr),
                          onTap: (){
                            Get.changeThemeMode(ThemeMode.dark);
                            Get.back();
                          }
                        ),
                      ],
                    ),
                  )
                );

              },
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 6,
            child: ListTile(
              leading: Icon(Icons.language),
              title: Text("change_language".tr),
              onTap: (){
                Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                              leading: Icon(Icons.light_mode),
                              title: Text("english".tr),
                              onTap: (){
                                Get.find<LanguageController>().changeLanguage('en', 'US');
                                Get.back();
                              }
                          ),
                          ListTile(
                              leading: Icon(Icons.dark_mode),
                              title: Text("bangla".tr),
                              onTap: (){
                                Get.find<LanguageController>().changeLanguage('bn', 'BD');
                                Get.back();
                              }
                          ),
                        ],
                      ),
                    )
                );

              },
            ),
          )
        ],
      )
    );
  }
}
