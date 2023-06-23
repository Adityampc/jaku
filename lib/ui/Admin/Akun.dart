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
        padding: EdgeInsets.all(5),
        child: RefreshIndicator(
            child: _body(context),
            onRefresh: () async {
              _refreshAkun();
              // return Future.delayed(Duration(seconds: 5));
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

  void onVertClick(User user) {
    AlertDialog alert = AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 7,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  hapusAkun(user);
                  Navigator.pop(context);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Center(child: Text("Hapus"))),
              ),
              GestureDetector(
                onTap: () => print("Ubah"),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.only(top: 2, bottom: 2),
                    child: Center(child: Text("Ubah"))),
              ),
            ]),
      ),
      actions: [
        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: const Text("OK"))
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }

  Future<List<User>> loadAkun() async {
    List<User> users = await AkunService().listData(null);
    return users;
  }

  void hapusAkun(User user) async {
    SnackBar snackOnDelete = SnackBar(
      content: Text("Menghapus akun " + user.username),
      // behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackOnDelete);
    AkunService().hapus(user.id).then((value) {
      SnackBar snackOnSuccess = SnackBar(
        content: Text("Berhasil menghapus akun " + value.username),
        // behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackOnSuccess);
      setState(() {
        users.remove(user);
      });
    });
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
            User user = users[index];
            return ItemAkun(
              user: user,
              onVertClick: () => onVertClick(user),
            );
          });
    }
  }
}
