import 'package:flutter/material.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';

class CheckingListComponent extends StatelessWidget {
  const CheckingListComponent({super.key});

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
              'http://192.168.1.13:8000/images/members/member1.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              children: const [
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Peternakan Al Sulaiman',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold, fontSize: 12),
                    )),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Jl. Suparman No. 19, Malang',
                      style: TextStyle(
                          fontFamily: FontPicker.regular,
                          fontSize: 10,
                          color: ColorPicker.grey)),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('Pending..',
                      style: TextStyle(
                          fontFamily: FontPicker.medium,
                          fontSize: 11,
                          color: ColorPicker.danger)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
