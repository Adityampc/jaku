import 'package:flutter/material.dart';
import 'package:jaku/helpers/user_info.dart';
import 'package:jaku/model/jadwal.dart';
import 'package:jaku/service/JadwalService.dart';
import 'package:jaku/ui/Member/Jadwal/Add.dart';
import 'package:jaku/ui/Member/Jadwal/Edit.dart';
import 'package:jaku/widget/item_jadwal.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool onUpdate = true;
  List<Jadwal> jadwals = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadJadwal().then((j) {
      setState(
        () {
          jadwals = j;
          onUpdate = false;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jadwal")),
      body: Container(
        padding: EdgeInsets.all(5),
        child: _body(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Add())),
        child: Icon(Icons.add),
      ),
    );
  }

  void onVertClick(Jadwal jadwal) {
    AlertDialog alert = AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 7,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  hapusJadwal(jadwal);
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
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Edit(
                                jadwal: jadwal,
                              )));
                },
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

  Future<List<Jadwal>> loadJadwal() async {
    String? uid = await UserInfo().getUserID();
    List<Jadwal> jadwals = await JadwalService().listData({"userId": uid});
    return jadwals;
  }

  void hapusJadwal(Jadwal jadwal) async {
    SnackBar snackOnDelete = SnackBar(
      content: Text("Menghapus jadwal " + jadwal.title),
      // behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackOnDelete);
    JadwalService().hapus(jadwal.id).then((value) {
      SnackBar snackOnSuccess = SnackBar(
        content: Text("Berhasil menghapus jadwal " + value.title),
        // behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackOnSuccess);
      setState(() {
        jadwals.remove(jadwal);
      });
    });
  }

  Widget _body(context) {
    if (onUpdate && jadwals.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else if (!onUpdate && jadwals.isEmpty) {
      return const Center(
        child: Text("Tidak ada jadwal!"),
      );
    } else {
      return ListView.builder(
          itemCount: jadwals.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Jadwal jadwal = jadwals[index];
            return ItemJadwal(
              jadwal: jadwal,
              onVertClick: () => onVertClick(jadwal),
            );
          });
    }
  }
}
