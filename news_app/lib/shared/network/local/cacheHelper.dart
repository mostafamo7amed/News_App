import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance() ;
  }

  static Future<bool> setDark({
    required String key,
    required bool isDark,
  }) async{
    return await sharedPreferences.setBool(key, isDark);
  }

  static bool? getDark({
    required String key,
  }){
    return sharedPreferences.getBool(key);
  }

}