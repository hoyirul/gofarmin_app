import 'package:flutter/material.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';

class ButtonMonitoringComponent extends StatelessWidget {
  final String text;
  final double height;
  final Color bg;
  final Color textColor;
  const ButtonMonitoringComponent(
      {super.key,
      required this.text,
      required this.height,
      required this.bg,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bg,
          boxShadow: const [
            BoxShadow(
                color: ColorPicker.greyLight,
                offset: Offset(0, 2),
                blurRadius: 1)
          ]),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontFamily: FontPicker.semibold,
                fontSize: 16,
                letterSpacing: 0.3),
            textAlign: TextAlign.center,
          )),
    );
  }
}
