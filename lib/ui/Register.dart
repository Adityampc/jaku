import 'package:flutter/material.dart';
import 'package:jaku/service/AuthService.dart';
import 'package:jaku/ui/Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  late FocusNode _nameFocus;
  late FocusNode _usernameFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _nameFocus = FocusNode();
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
                  "Daftar akun baru",
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
                          _nameTextField(),
                          SizedBox(
                            height: 20,
                          ),
                          _usernameTextField(),
                          SizedBox(
                            height: 20,
                          ),
                          _passwordTextField(),
                          SizedBox(
                            height: 40,
                          ),
                          _tombolRegister(),
                          SizedBox(
                            height: 20,
                          ),
                          _tombolLogin()
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

  Widget _nameTextField() {
    return TextFormField(
      onFieldSubmitted: (v) => doRegister(),
      decoration: const InputDecoration(
        label: Text("Nama"),
      ),
      focusNode: _nameFocus,
      controller: _nameCtrl,
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      onFieldSubmitted: (v) => doRegister(),
      decoration: const InputDecoration(
        label: Text("Username"),
      ),
      focusNode: _usernameFocus,
      controller: _usernameCtrl,
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      onFieldSubmitted: (v) => doRegister(),
      decoration: const InputDecoration(
        label: Text("Password"),
      ),
      focusNode: _passwordFocus,
      controller: _passwordCtrl,
    );
  }

  Widget _tombolRegister() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(onPressed: doRegister, child: Text("Daftar")),
    );
  }

  Widget _tombolLogin() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(onPressed: doLogin, child: Text("Masuk")),
    );
  }

  bool fieldOk() {
    if (_nameCtrl.text == "") {
      _nameFocus.requestFocus();
      return false;
    }
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

  void doLogin() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (Route<dynamic> route) => false);
  }

  void doRegister() async {
    if (!fieldOk()) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Register..."),
    ));

    String name = _nameCtrl.text;
    String username = _usernameCtrl.text;
    String password = _passwordCtrl.text;
    bool isRegistered = await AuthService().register(name, username, password);
    String txt = "Berhasil mendaftarkan akun";
    if (!isRegistered) txt = "Gagal mendaftarkan akun";
    AlertDialog alert = AlertDialog(
      content: Text(txt),
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
}
