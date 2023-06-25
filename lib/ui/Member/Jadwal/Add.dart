import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jaku/helpers/user_info.dart';
import 'package:jaku/service/JadwalService.dart';

import '../../../model/jadwal.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _timeCtrl = TextEditingController();
  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _timeFocus;

  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _timeFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Jadwal")),
      body: Container(
        child: Form(
          key: _formKey,
          child: Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1.3,
              child: Column(
                children: [
                  _titleTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  _descriptionTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  _dateTimeField(),
                  SizedBox(
                    height: 40,
                  ),
                  _tombolTambah()
                ],
              )),
        ),
      ),
    );
  }

  Widget _titleTextField() {
    return TextFormField(
      onFieldSubmitted: (v) => doTambah,
      decoration: const InputDecoration(
        label: Text("Title"),
      ),
      focusNode: _titleFocus,
      controller: _titleCtrl,
    );
  }

  Widget _descriptionTextField() {
    return TextFormField(
      onFieldSubmitted: (v) => doTambah,
      decoration: const InputDecoration(
        label: Text("Deskripsi"),
      ),
      focusNode: _descriptionFocus,
      controller: _descriptionCtrl,
    );
  }

  Widget _dateTimeField() {
    return DateTimeField(
      format: format,
      focusNode: _timeFocus,
      controller: _timeCtrl,
      onFieldSubmitted: (v) => doTambah(),
      onShowPicker: (context, currentValue) async {
        return await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
        ).then((DateTime? date) async {
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        });
      },
    );
  }

  bool fieldOk() {
    if (_titleCtrl.text == "") {
      _titleFocus.requestFocus();
      return false;
    }
    if (_descriptionCtrl.text == "") {
      _descriptionFocus.requestFocus();
      return false;
    }
    if (_timeCtrl.text == "") {
      _timeFocus.requestFocus();
      return false;
    }
    return true;
  }

  Widget _tombolTambah() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(onPressed: doTambah, child: Text("Tambah")),
    );
  }

  void doTambah() async {
    if (!fieldOk()) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Menambahkan"),
    ));
    String? uid = await UserInfo().getUserID();
    Jadwal jadwal = Jadwal(
        id: "",
        userId: "user${uid}Id",
        title: _titleCtrl.text,
        description: _descriptionCtrl.text,
        datetime: DateTime.parse(_timeCtrl.text).millisecondsSinceEpoch);
    Jadwal isAdded = await JadwalService().tambah(jadwal);
    setState(() {
      _titleCtrl.text = "";
      _descriptionCtrl.text = "";
      _timeCtrl.text = "";
    });
    AlertDialog alert = AlertDialog(
      content: const Text("Berhasil menambahkan jadwal"),
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
