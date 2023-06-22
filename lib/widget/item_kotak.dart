import 'package:flutter/material.dart';

class ItemKotak extends StatefulWidget {
  ItemKotak({super.key, required this.itemTengah, this.onTap});
  Widget itemTengah;
  Function? onTap;

  @override
  State<ItemKotak> createState() => _ItemKotakState();
}

class _ItemKotakState extends State<ItemKotak> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
      child: InkWell(
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: () => {if (widget.onTap != null) widget.onTap!()},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: widget.itemTengah,
        ),
      ),
    );
  }
}
