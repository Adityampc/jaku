import 'package:flutter/material.dart';
import 'package:jaku/model/user.dart';

class ItemAkun extends StatefulWidget {
  ItemAkun({super.key, required this.user});
  User user;

  @override
  State<ItemAkun> createState() => _ItemAkunState();
}

class _ItemAkunState extends State<ItemAkun> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.user.name),
    );
  }
}
