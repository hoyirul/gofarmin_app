import 'package:flutter/material.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/investors/invests/detail_goat_screen.dart';

class GoatListComponent extends StatelessWidget {
  const GoatListComponent({super.key});

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
              'http://192.168.1.13:8000/images/members/member3.jpg',
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
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('1,299K',
                      style: TextStyle(
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
                    button: TextButton(
                        onPressed: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       title: const Text('Kambing Kacang'),
                          //       content: const TextField(
                          //         decoration: InputDecoration(
                          //           hintText: 'Enter your name',
                          //         ),
                          //       ),
                          //       actions: [
                          //         TextButton(
                          //           child: const Text('Cancel'),
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //         ),
                          //         TextButton(
                          //           child: const Text('OK'),
                          //           onPressed: () {
                          //             // Proses data dari inputan di sini
                          //             Navigator.of(context).pop();
                          //           },
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                          Get.to(const DetailGoatInvestorScreen(),
                              transition: Transition.native);
                        },
                        child: const Text(
                          'Invest Now',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontPicker.semibold,
                              color: ColorPicker.primary),
                        ))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
