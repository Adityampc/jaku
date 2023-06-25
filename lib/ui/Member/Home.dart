import 'package:flutter/material.dart';
import 'package:jaku/helpers/user_info.dart';
import 'package:jaku/ui/Login.dart';
import 'package:jaku/ui/Member/Jadwal/Main.dart';
import 'package:jaku/widget/item_kotak.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jadwal Ku")),
      body: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: [
          ItemKotak(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Main())),
              itemTengah: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month),
                  SizedBox(height: 10),
                  Text("Jadwal"),
                ],
              )),
          ItemKotak(
              onTap: () => _logout(context),
              itemTengah: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  SizedBox(height: 10),
                  Text("Keluar"),
                ],
              )),
        ],
      ),
    );
  }

  void _logout(context) {
    AlertDialog alert = AlertDialog(
      content: const Text("Anda akan keluar dari akun?"),
      actions: [
        ElevatedButton(
            onPressed: () async {
              await UserInfo().logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (Route<dynamic> route) => false);
            },
            child: const Text("Keluar")),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal"))
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }
}
