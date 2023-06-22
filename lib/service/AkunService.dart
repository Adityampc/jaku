import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jaku/helpers/api_client.dart';
import 'package:jaku/model/user.dart';

class AkunService {
  Future<List<User>> listData(opt) async {
    String url = 'users?';
    if (opt != null) {
      if (opt["p"]) url = "$url&p=${opt['p']}";
      if (opt["l"]) url = "$url&l=${opt['l']}";
    }
    final Response response = await ApiClient().get(url);
    final List data = response.data as List;
    List<User> users = data.map((e) => User.fromJson(e)).toList();
    return users;
  }
}
