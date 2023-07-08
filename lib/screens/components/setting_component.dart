import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:flutter/material.dart';

class SettingComponentFeatures extends StatelessWidget {
  final String title;
  final Icon icon;
  const SettingComponentFeatures(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      margin: const EdgeInsets.only(bottom: 10),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPicker.white,
          boxShadow: const [
            BoxShadow(
                color: ColorPicker.greyLight,
                offset: Offset(0, 2),
                blurRadius: 1)
          ]),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
              fontFamily: FontPicker.medium,
              color: ColorPicker.dark,
              fontSize: 14),
        ),
        trailing: icon,
      ),
    );
  }
}
