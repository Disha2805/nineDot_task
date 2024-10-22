import 'package:shared_preferences/shared_preferences.dart';

final preferences = SharedPreference();

class SharedPreference {
  static SharedPreferences? _preferences;
  init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static const isLogin = "isLogIn";
  static const fcmToken = "fcmToken";
  static const accessAuthToken = "accessAuthToken";
  static const accessToken = "accessToken";
  static const userId = "UserId";


  logOut() async {
    await _preferences!.clear();
  }

  ///string value
  Future<bool?> putString(String key, String value) async {
    return _preferences?.setString(key, value);
  }

  String? getString(String key, {String defValue = ""}) {
    return _preferences == null
        ? defValue
        : _preferences!.getString(key) ?? defValue;
  }

  ///bool value
  Future<bool?> putBool(String key, bool value) async {
    return _preferences?.setBool(key, value);
  }

  bool? getBool(String key, {bool defValue = false}) {
    return _preferences == null
        ? defValue
        : _preferences!.getBool(key) ?? defValue;
  }
}
