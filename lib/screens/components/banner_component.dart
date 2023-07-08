import 'package:flutter/material.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';

class BannerComponent extends StatelessWidget {
  const BannerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorPicker.white,
        boxShadow: const [
          BoxShadow(
              color: ColorPicker.greyLight, offset: Offset(0, 2), blurRadius: 1)
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: 'Why ',
                          style: TextStyle(
                              fontFamily: FontPicker.semibold,
                              color: ColorPicker.dark,
                              fontSize: 17)),
                      TextSpan(
                          text: 'Go',
                          style: TextStyle(
                              fontFamily: FontPicker.semibold,
                              color: ColorPicker.primary,
                              fontSize: 17)),
                      TextSpan(
                          text: 'Farmin',
                          style: TextStyle(
                              fontFamily: FontPicker.semibold,
                              color: ColorPicker.dark,
                              fontSize: 17)),
                    ]),
                  )),
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: const TextSpan(
                        style: TextStyle(height: 1.5),
                        children: [
                          TextSpan(
                              text: 'Berinvestasi di peternakan ',
                              style: TextStyle(
                                  fontFamily: FontPicker.regular,
                                  color: ColorPicker.grey,
                                  fontSize: 12)),
                          TextSpan(
                              text: 'kambing ',
                              style: TextStyle(
                                  fontFamily: FontPicker.regular,
                                  color: ColorPicker.primary,
                                  fontSize: 12)),
                          TextSpan(
                              text: 'untung ',
                              style: TextStyle(
                                  fontFamily: FontPicker.regular,
                                  color: ColorPicker.grey,
                                  fontSize: 12)),
                          TextSpan(
                              text: 'melimpah ',
                              style: TextStyle(
                                  fontFamily: FontPicker.regular,
                                  color: ColorPicker.yellow,
                                  fontSize: 12)),
                          TextSpan(
                              text: 'setiap musimnya!',
                              style: TextStyle(
                                  fontFamily: FontPicker.regular,
                                  color: ColorPicker.grey,
                                  fontSize: 12)),
                        ]),
                  )),
            ],
          )),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(0),
              height: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/whatisnew.png'),
            ),
          )
        ],
      ),
    );
  }
}
