import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setBool(key, value) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool getBool(key) {
    return sharedPreferences.getBool(key) ?? false;
  }

  static Future<bool> setDouble(key, value) async {
    return await sharedPreferences.setDouble(key, value);
  }

  static double getDouble(key) {
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  static Future<bool> setInt(key, value) async {
    return await sharedPreferences.setInt(key, value);
  }

  static int getInt(key) {
    return sharedPreferences.getInt(key) ?? 0;
  }

  static Future<bool> setString(key, value) async {
    return await sharedPreferences.setString(key, value);
  }

  static String getString(key) {
    return sharedPreferences.getString(key) ?? '';
  }

  static Future<bool> setList(key, value) async {
    return await sharedPreferences.setStringList(key, value);
  }

  static List<String> getList(key) {
    return sharedPreferences.getStringList(key) ?? [];
  }

  static void clear() {
    sharedPreferences.clear();
  }
}
