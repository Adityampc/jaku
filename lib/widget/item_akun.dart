import 'package:flutter/material.dart';
import 'package:jaku/model/user.dart';

class ItemAkun extends StatefulWidget {
  ItemAkun({super.key, required this.user, this.onVertClick});
  User user;
  Function? onVertClick;

  @override
  State<ItemAkun> createState() => _ItemAkunState();
}

class _ItemAkunState extends State<ItemAkun> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2, bottom: 2),
      padding: EdgeInsets.all(5),
      height: 60,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.user.username,
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    if (widget.onVertClick != null) widget.onVertClick!();
                  },
                  child: Icon(Icons.more_vert))
            ],
          )
        ],
      ),
    );
  }
}
