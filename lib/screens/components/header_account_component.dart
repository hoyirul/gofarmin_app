import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderAccountComponent extends StatefulWidget {
  final InkWell inkWell;
  const HeaderAccountComponent({super.key, required this.inkWell});

  @override
  State<HeaderAccountComponent> createState() => _HeaderAccountComponentState();
}

class _HeaderAccountComponentState extends State<HeaderAccountComponent> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.inkWell,
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {},
          child: Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  color: ColorPicker.greyLight, shape: BoxShape.circle),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: FutureBuilder(
            future: profileController.getName(),
            builder: (context, snapshot) {
              return Text(
                '${snapshot.data}',
                style: const TextStyle(
                    fontFamily: FontPicker.semibold, fontSize: 18),
              );
            },
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: FutureBuilder(
            future: profileController.getAddress(),
            builder: (context, snapshot) {
              return Text(
                '${snapshot.data}',
                style: const TextStyle(
                    fontFamily: FontPicker.regular, fontSize: 14),
              );
            },
          ),
        ),
      ],
    );
  }
}
