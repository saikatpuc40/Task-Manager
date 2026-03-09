import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:task_manager/translations/bn_bd.dart';
import 'package:task_manager/translations/en_us.dart';

class AppTranslations extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>{
    'en_US': enUS,
    'bn_BD': bnBD,
  };

}