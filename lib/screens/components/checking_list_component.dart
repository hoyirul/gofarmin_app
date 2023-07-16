import 'package:flutter/material.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';

class CheckingListComponent extends StatelessWidget {
  final String name, address, img, status;
  const CheckingListComponent(
      {super.key,
      required this.name,
      required this.address,
      required this.img,
      required this.status});

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
              img,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontFamily: FontPicker.semibold, fontSize: 12),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(address,
                      style: const TextStyle(
                          fontFamily: FontPicker.regular,
                          fontSize: 10,
                          color: ColorPicker.grey)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      (status == 'worthy') ? 'Complete...' : 'Pending...',
                      style: TextStyle(
                          fontFamily: FontPicker.medium,
                          fontSize: 11,
                          color: (status == 'worthy')
                              ? ColorPicker.primary
                              : ColorPicker.danger)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
