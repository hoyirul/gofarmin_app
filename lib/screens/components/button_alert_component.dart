import 'package:flutter/material.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';

class ButtonAlertComponent extends StatelessWidget {
  final String text;
  final Color colors;
  const ButtonAlertComponent(
      {super.key, required this.text, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors.withOpacity(0.1),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontFamily: FontPicker.semibold, color: colors),
          ),
        ));
  }
}
