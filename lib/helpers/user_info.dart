import 'package:shared_preferences/shared_preferences.dart';

const String USERID = "userID";
const String USERNAME = "username";
const String ISADMIN = "isAdmin";

class UserInfo {
  Future setUserID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(USERID, value);
  }

  Future<String?> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USERID);
  }

  Future setUsername(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(USERNAME, value);
  }

  Future<String?> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USERNAME);
  }

  Future setIsAdmin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(ISADMIN, value);
  }

  Future<bool?> getIsAdmin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(ISADMIN);
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
