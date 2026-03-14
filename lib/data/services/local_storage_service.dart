import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService{
  static const String languageCode = "languageCode";
  static const String countryCode = "countryCode";

  static Future<void> saveLanguage(String lang, String country) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(languageCode, lang);
    sharedPreferences.setString(countryCode, country);
  }

  static Future<Map<String,String>> getLanguage() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String lang = sharedPreferences.getString(languageCode) ?? 'en';
    String country = sharedPreferences.getString(countryCode) ?? 'US';
    return{
      'lang':lang,
      'country' : country,
    };

  }
}