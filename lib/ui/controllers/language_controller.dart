import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/local_storage_service.dart';

class LanguageController extends GetxController{
  Locale locale = const Locale('en','US');
  Future <void> loadLanguage() async {
    final data = await LocalStorageService.getLanguage();
    locale = Locale(data['lang']!,data['country']!);
    Get.updateLocale(locale);
    update();
  }
  Future<void> changeLanguage(String lang, String country) async {
    locale = Locale(lang,country);
    Get.updateLocale(locale);
    await LocalStorageService.saveLanguage(lang, country);
    update();
  }
}