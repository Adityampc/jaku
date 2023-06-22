import 'package:flutter/material.dart';
import 'package:jaku/helpers/user_info.dart';
import 'package:jaku/ui/Admin/Akun.dart';
import 'package:jaku/ui/login.dart';
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
                  MaterialPageRoute(builder: (context) => const Akun())),
              itemTengah: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  SizedBox(height: 10),
                  Text("Akun"),
                ],
              )),
          ItemKotak(
              onTap: () => _logout(context),
              itemTengah: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.key),
                  SizedBox(height: 10),
                  Text("Password"),
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));
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
