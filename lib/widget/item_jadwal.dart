import 'package:flutter/material.dart';
import 'package:jaku/model/jadwal.dart';
import 'package:intl/intl.dart';

class ItemJadwal extends StatefulWidget {
  ItemJadwal({super.key, required this.jadwal, this.onVertClick});
  Jadwal jadwal;
  Function? onVertClick;

  @override
  State<ItemJadwal> createState() => _ItemJadwalState();
}

class _ItemJadwalState extends State<ItemJadwal> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2, bottom: 2),
      padding: EdgeInsets.all(5),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.jadwal.title,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.jadwal.description ?? 'Tidak ada deskripsi',
                style: TextStyle(fontSize: 9),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                formatter
                    .format(DateTime.fromMillisecondsSinceEpoch(
                        widget.jadwal.datetime))
                    .toString(),
                style: TextStyle(fontSize: 9),
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
