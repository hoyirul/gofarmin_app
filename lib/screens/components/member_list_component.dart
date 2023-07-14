import 'package:flutter/material.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';

class MemberListComponent extends StatelessWidget {
  final String img;
  const MemberListComponent({super.key, required this.img});

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
              '${HttpHelper().url}/images/members/$img.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Column(
              children: const [
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Peternakan Al Sulaiman',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold, fontSize: 14),
                    )),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Jl. Suparman No. 19, Malang',
                      style: TextStyle(
                          fontFamily: FontPicker.regular,
                          fontSize: 11,
                          color: ColorPicker.grey)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
