import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:flutter/material.dart';

class LabelComponent extends StatelessWidget {
  final String label;
  const LabelComponent({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: const TextStyle(
                    fontFamily: FontPicker.medium,
                    fontSize: 13,
                    color: ColorPicker.dark),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
