import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jaku/helpers/api_client.dart';
import 'package:jaku/model/jadwal.dart';

class JadwalService {
  Future<List<Jadwal>> listData(opt) async {
    String url = 'schedule?';
    if (opt != null) {
      if (opt["p"] != null) url = "$url&p=${opt['p']}";
      if (opt["l"] != null) url = "$url&l=${opt['l']}";
      if (opt["userId"] != null) url = "$url&userId=user${opt['userId']}Id";
      url = "$url&sortBy=datetime";
      url = "$url&order=desc";
    }
    final Response response = await ApiClient().get(url);
    final List data = response.data as List;
    List<Jadwal> jadwals = data.map((e) => Jadwal.fromJson(e)).toList();
    return jadwals;
  }

  Future<Jadwal> hapus(id) async {
    final Response response = await ApiClient().delete("schedule/$id");
    Jadwal user = Jadwal.fromJson(response.data);
    return user;
  }

  Future<Jadwal> ubah(jadwal) async {
    final Response response =
        await ApiClient().put("schedule/${jadwal['id']}", jadwal);
    Jadwal j = Jadwal.fromJson(response.data);
    return j;
  }

  Future<Jadwal> tambah(Jadwal jadwal) async {
    final Response response =
        await ApiClient().post("schedule", jadwal.toJson());
    Jadwal j = Jadwal.fromJson(response.data);
    return j;
  }
}
