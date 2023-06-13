import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static const String _quantityKey = 'quantity';

  static Future<int> getQuantity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_quantityKey) ?? 0;
  }

  static Future<void> saveQuantity(int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_quantityKey, quantity);
  }

  ///keys
  // static String userLoggedInKey = 'LoggedInKey';
  // static String userNameKey = 'UserNameKey';
  // static String userEmailKey = 'UserEmailKey';
  //
  // /// saving data to shared pref...
  // static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return await sharedPreferences.setBool(userLoggedInKey, isUserLoggedIn);
  // }
  //
  // static Future<bool> saveUserNameSf(String username) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return await sharedPreferences.setString(userNameKey, username);
  // }
  //
  // static Future<bool> saveUserEmailSf(String email) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return await sharedPreferences.setString(userLoggedInKey, email);
  // }
  //
  // /// getting the data from shared pref..
  // static Future<bool?> getUserLoggedInStatus() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return sharedPreferences.getBool(userLoggedInKey);
  // }
  //
  // static Future<String?> getUserEmailFromSf() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return sharedPreferences.getString(userEmailKey);
  // }
  //
  // static Future<String?> getUserNameFromSf() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return sharedPreferences.getString(userNameKey);
  // }
}
