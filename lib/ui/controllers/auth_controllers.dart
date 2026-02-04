import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';

class AuthControllers{
  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  static String accessToken = '';
  static UserModel?userData;

  static Future<void> saveUserAccessToken(String token)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> getUserAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_accessTokenKey);
  }

  static Future<void> saveUserData(UserModel user) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));
  }

  static Future<UserModel?> getUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString(_userDataKey);
    if(userData == null) return null;
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));
    return userModel;
  }


  static Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_accessTokenKey);
    await sharedPreferences.remove(_userDataKey);
  }

  static Future<bool> checkAuthState() async{
    String? token = await getUserAccessToken();
    if(token == null) return false;
    accessToken = token;
    userData = await getUserData();

    return true;

  }
}