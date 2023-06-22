import 'package:flutter/material.dart';
import 'package:jaku/model/user.dart';
import 'package:jaku/service/AkunService.dart';
import 'package:jaku/widget/item_akun.dart';

class Akun extends StatefulWidget {
  const Akun({super.key});

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  bool onUpdate = true;
  List<User> users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshAkun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Akun")),
      body: Container(
        child: RefreshIndicator(
            child: Stack(
              children: [
                _body(context),
              ],
            ),
            onRefresh: () async {
              _refreshAkun();
              return Future.delayed(Duration(seconds: 5));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("ADD"),
        child: Icon(Icons.add),
      ),
    );
  }

  void _refreshAkun() async {
    List<User> u = await loadAkun();
    setState(
      () {
        users = u;
        onUpdate = false;
      },
    );
  }

  Future<List<User>> loadAkun() async {
    List<User> users = await AkunService().listData(null);
    return users;
  }

  Widget _body(context) {
    if (onUpdate && users.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else if (!onUpdate && users.isEmpty) {
      return const Center(
        child: Text("Tidak ada akun!"),
      );
    } else {
      return ListView.builder(
          itemCount: users.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ItemAkun(user: users[index]);
          });
    }
  }
}
