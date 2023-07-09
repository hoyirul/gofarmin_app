import 'package:flutter/material.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';

class TabButtonComponent extends StatelessWidget {
  final String text;
  final Color colors;
  const TabButtonComponent(
      {super.key, required this.text, required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPicker.white,
            boxShadow: const [
              BoxShadow(
                  color: ColorPicker.greyLight,
                  offset: Offset(0, 2),
                  blurRadius: 1)
            ]),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: colors, fontFamily: FontPicker.medium, fontSize: 14),
        )),
      ),
    );
  }
}
