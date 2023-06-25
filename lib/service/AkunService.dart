import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jaku/helpers/api_client.dart';
import 'package:jaku/model/user.dart';

class AkunService {
  Future<List<User>> listData(opt) async {
    String url = 'users?';
    if (opt != null) {
      if (opt["p"] != null) url = "$url&p=${opt['p']}";
      if (opt["l"] != null) url = "$url&l=${opt['l']}";
      if (opt["isAdmin"] != null) url = "$url&isAdmin=${opt['isAdmin']}";
    }
    final Response response = await ApiClient().get(url);
    final List data = response.data as List;
    List<User> users = data.map((e) => User.fromJson(e)).toList();
    return users;
  }

  Future<User> hapus(id) async {
    final Response response = await ApiClient().delete("users/$id");
    User user = User.fromJson(response.data);
    return user;
  }
}
