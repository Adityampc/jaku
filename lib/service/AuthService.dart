import 'package:dio/dio.dart';
import 'package:jaku/helpers/api_client.dart';
import 'package:jaku/helpers/user_info.dart';
import 'package:jaku/model/user.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    final Response response =
        await ApiClient().get("users?username=" + username);
    final List data = response.data as List;
    if (data.isEmpty) return false;
    User user = User.fromJson(data[0]);
    if (user.password != password) return false;
    await UserInfo().setUserID(user.id);
    await UserInfo().setUsername(user.username);
    await UserInfo().setIsAdmin(user.isAdmin);
    return true;
  }

  Future<bool> register(String name, String username, String password) async {
    final Response r = await ApiClient().get("users?username=" + username);
    final List data = r.data as List;
    if (!data.isEmpty) return false;

    final Response response = await ApiClient().post("users", {
      "name": name,
      "username": username,
      "password": password,
      "isAdmin": false
    });
    try {
      User user = User.fromJson(response.data);
      await UserInfo().setUserID(user.id);
      await UserInfo().setUsername(user.username);
      await UserInfo().setIsAdmin(user.isAdmin);
      return true;
    } catch (e) {
      return false;
    }
  }
}
