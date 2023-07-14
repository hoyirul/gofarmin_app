import 'package:flutter/material.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';

class GoatListComponent extends StatelessWidget {
  final String price;
  final TextButton route;
  const GoatListComponent(
      {super.key, required this.price, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorPicker.white,
        boxShadow: const [
          BoxShadow(
              color: ColorPicker.greyLight, offset: Offset(0, 2), blurRadius: 1)
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.network(
              '${HttpHelper().url}/images/members/member3.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Kambing Kacang',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold, fontSize: 14),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(price,
                      style: const TextStyle(
                          fontFamily: FontPicker.bold,
                          fontSize: 22,
                          color: ColorPicker.dark)),
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonComponent(
                    height: 40,
                    width: double.infinity,
                    colors: ColorPicker.rectangle,
                    button: route),
              ],
            ),
          )
        ],
      ),
    );
  }
}
