import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:flutter/material.dart';

class CircleComponent extends StatelessWidget {
  final double height, width;
  const CircleComponent({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: height,
      width: width,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: ColorPicker.shape),
    );
  }
}
