import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/goat_list_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/tab_button_component.dart';
import 'package:gofarmin_app/screens/investors/home/home_screen.dart';
import 'package:gofarmin_app/screens/investors/invests/detail_goat_screen.dart';

class DetailMemberInvestorScreen extends StatefulWidget {
  const DetailMemberInvestorScreen({super.key});

  @override
  State<DetailMemberInvestorScreen> createState() =>
      _DetailMemberInvestorScreenState();
}

class _DetailMemberInvestorScreenState
    extends State<DetailMemberInvestorScreen> {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                  ),
                  child: Image.network(
                    'http://192.168.1.13:8000/images/members/member4.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 25,
                child: InkWell(
                  onTap: () => Get.to(const HomeInvestorScreen(),
                      transition: Transition.leftToRight),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPicker.white.withOpacity(0.4),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: ColorPicker.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Peternakan Al Hidayah',
                      style: TextStyle(
                          fontFamily: FontPicker.bold,
                          color: ColorPicker.dark,
                          fontSize: 22),
                    )),
                const SizedBox(
                  height: 8,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Jl. Raya Tumbang, Malang, Jawa Timur',
                      style: TextStyle(
                          fontFamily: FontPicker.regular,
                          color: ColorPicker.primary,
                          fontSize: 12),
                    )),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Peternakan ini telah terverifikasi oleh GoFarmin dan sudah bisa berinvestasi di peternakan ini. Selamat berinvestasi nyata.',
                      style: TextStyle(
                          fontFamily: FontPicker.regular,
                          color: ColorPicker.grey,
                          fontSize: 12),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Expanded(
                        child: TabButtonComponent(
                      text: 'Jantan',
                      colors: ColorPicker.primary,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TabButtonComponent(
                      text: 'Betina',
                      colors: ColorPicker.grey,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                GridView.count(
                  padding: const EdgeInsets.all(0),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  childAspectRatio: (4 / 6),
                  shrinkWrap: true,
                  children: [
                    GoatListComponent(
                      price: '1,299K',
                      route: TextButton(
                          onPressed: () {
                            Get.to(const DetailGoatInvestorScreen(),
                                transition: Transition.native);
                          },
                          child: const Text(
                            'Invest Now',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: FontPicker.semibold,
                                color: ColorPicker.primary),
                          )),
                    ),
                    GoatListComponent(
                      price: '1,299K',
                      route: TextButton(
                          onPressed: () {
                            Get.to(const DetailGoatInvestorScreen(),
                                transition: Transition.native);
                          },
                          child: const Text(
                            'Invest Now',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: FontPicker.semibold,
                                color: ColorPicker.primary),
                          )),
                    ),
                    GoatListComponent(
                      price: '1,299K',
                      route: TextButton(
                          onPressed: () {
                            Get.to(const DetailGoatInvestorScreen(),
                                transition: Transition.native);
                          },
                          child: const Text(
                            'Invest Now',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: FontPicker.semibold,
                                color: ColorPicker.primary),
                          )),
                    ),
                    GoatListComponent(
                      price: '1,299K',
                      route: TextButton(
                          onPressed: () {
                            Get.to(const DetailGoatInvestorScreen(),
                                transition: Transition.native);
                          },
                          child: const Text(
                            'Invest Now',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: FontPicker.semibold,
                                color: ColorPicker.primary),
                          )),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
