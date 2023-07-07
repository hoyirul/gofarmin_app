
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final double height, width;
  final Color colors;
  final TextButton button;
  const ButtonComponent(
      {super.key,
      required this.button,
      required this.colors,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: colors),
        child: button,
      ),
    );
  }
}
