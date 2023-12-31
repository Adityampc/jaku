import 'package:flutter/material.dart';
import 'package:jaku/helpers/user_info.dart';
import 'package:jaku/service/AuthService.dart';
import 'package:jaku/ui/Admin/Home.dart' as AdminHome;
import 'package:jaku/ui/Member/Home.dart' as MemberHome;
import 'package:jaku/ui/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  late FocusNode _usernameFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Masuk untuk melanjutkan",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 50),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          _usernameTextField(),
                          SizedBox(
                            height: 20,
                          ),
                          _passwordTextField(),
                          SizedBox(
                            height: 40,
                          ),
                          _tombolLogin(),
                          SizedBox(
                            height: 20,
                          ),
                          _tombolRegister()
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    ));
  }

  Widget _usernameTextField() {
    return TextFormField(
      onFieldSubmitted: (v) => doLogin(),
      decoration: const InputDecoration(
        label: Text("Username"),
      ),
      focusNode: _usernameFocus,
      controller: _usernameCtrl,
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      onFieldSubmitted: (v) => doLogin(),
      decoration: const InputDecoration(
        label: Text("Password"),
      ),
      focusNode: _passwordFocus,
      controller: _passwordCtrl,
    );
  }

  Widget _tombolLogin() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(onPressed: doLogin, child: Text("Masuk")),
    );
  }

  Widget _tombolRegister() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(onPressed: doRegister, child: Text("Daftar")),
    );
  }

  bool fieldOk() {
    if (_usernameCtrl.text == "") {
      _usernameFocus.requestFocus();
      return false;
    }
    if (_passwordCtrl.text == "") {
      _passwordFocus.requestFocus();
      return false;
    }
    return true;
  }

  void doRegister() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Register()),
        (Route<dynamic> route) => false);
  }

  void doLogin() async {
    if (!fieldOk()) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Logging..."),
    ));

    String username = _usernameCtrl.text;
    String password = _passwordCtrl.text;
    bool isAuthenticated = await AuthService().login(username, password);
    if (!isAuthenticated) {
      AlertDialog alert = AlertDialog(
        content: const Text("Username atau Password Tidak Valid"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"))
        ],
      );
      return showDialog(context: context, builder: (context) => alert);
    }
    bool? isAdmin = await UserInfo().getIsAdmin();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => (isAdmin ?? false)
                ? const AdminHome.Home()
                : const MemberHome.Home()),
        (Route<dynamic> route) => false);
  }
}
