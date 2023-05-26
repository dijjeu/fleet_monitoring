import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  static Future<String?> login(String phone, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPhone = prefs.getString('phone');
    String? savedPassword = prefs.getString('password');

    if (savedPhone != null && savedPassword != null) {
      if (phone == savedPhone && password == savedPassword) {
        return savedPhone;
      }
    }

    return null;
  }

  static Future<String?> getLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loggedInUser');
  }
}
