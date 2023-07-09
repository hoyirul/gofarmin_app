import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/banner_component.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:gofarmin_app/screens/components/circle_component.dart';
import 'package:gofarmin_app/screens/components/home_feature_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/member_list_component.dart';
import 'package:gofarmin_app/screens/components/tab_button_component.dart';
import 'package:gofarmin_app/screens/investors/accounts/account_screen.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/investors/home/home_screen.dart';
import 'package:gofarmin_app/screens/investors/invests/detail_member_screen.dart';

class PortofolioInvestorScreen extends StatefulWidget {
  const PortofolioInvestorScreen({super.key});

  @override
  State<PortofolioInvestorScreen> createState() =>
      _PortofolioInvestorScreenState();
}

class _PortofolioInvestorScreenState extends State<PortofolioInvestorScreen> {
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
                height: 200,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50)),
                    color: ColorPicker.primary),
              ),
              const Positioned(
                right: -10,
                top: -20,
                child: CircleComponent(height: 150, width: 150),
              ),
              const Positioned(
                left: -25,
                top: 50,
                child: CircleComponent(height: 100, width: 100),
              ),
              Positioned(
                left: 25,
                top: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Portofolio',
                      style: TextStyle(
                          fontFamily: FontPicker.regular,
                          fontSize: 12,
                          color: ColorPicker.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    FutureBuilder(
                      future: profileController.getName(),
                      builder: (context, snapshot) {
                        return const Text(
                          // 'Hi, ${snapshot.data}',
                          '4,299,000',
                          style: TextStyle(
                              fontFamily: FontPicker.bold,
                              fontSize: 30,
                              color: ColorPicker.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 25,
                top: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '1,299K / goat',
                      style: TextStyle(
                          fontFamily: FontPicker.regular,
                          fontSize: 14,
                          color: ColorPicker.white),
                    ),
                    Text(
                      '4 Goats',
                      style: TextStyle(
                          fontFamily: FontPicker.regular,
                          fontSize: 14,
                          color: ColorPicker.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                right: 25,
                child: InkWell(
                  onTap: () => Get.to(const HomeInvestorScreen(),
                      transition: Transition.fadeIn),
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
            height: 20,
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
                      'Transactions',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold,
                          color: ColorPicker.dark,
                          fontSize: 18),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Expanded(
                        child: TabButtonComponent(
                      text: 'Orders',
                      colors: ColorPicker.primary,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TabButtonComponent(
                      text: 'Histories',
                      colors: ColorPicker.grey,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPicker.white,
                        boxShadow: const [
                          BoxShadow(
                              color: ColorPicker.greyLight,
                              offset: Offset(0, 1),
                              blurRadius: 1)
                        ]),
                    child: InkWell(
                      onTap: () async {},
                      child: ListTile(
                          contentPadding: const EdgeInsets.all(5),
                          title: const Text(
                            'Kambing Kacang',
                            style: TextStyle(fontFamily: FontPicker.semibold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Buy Order - Pending',
                                style: TextStyle(
                                    fontFamily: FontPicker.regular,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '11 April 2023',
                                style: TextStyle(
                                    fontFamily: FontPicker.regular,
                                    fontSize: 12,
                                    color: ColorPicker.orange),
                              ),
                            ],
                          ),
                          trailing: Wrap(
                            children: const [
                              Text(
                                '1,299K',
                                style: TextStyle(
                                    fontFamily: FontPicker.semibold,
                                    color: ColorPicker.primary,
                                    fontSize: 22),
                              ),
                            ],
                          )),
                    )),
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPicker.white,
                        boxShadow: const [
                          BoxShadow(
                              color: ColorPicker.greyLight,
                              offset: Offset(0, 1),
                              blurRadius: 1)
                        ]),
                    child: InkWell(
                      onTap: () async {},
                      child: ListTile(
                          contentPadding: const EdgeInsets.all(5),
                          title: const Text(
                            'Kambing Etawa',
                            style: TextStyle(fontFamily: FontPicker.semibold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Sell Order - Success',
                                style: TextStyle(
                                    fontFamily: FontPicker.regular,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '01 April 2023',
                                style: TextStyle(
                                    fontFamily: FontPicker.regular,
                                    fontSize: 12,
                                    color: ColorPicker.orange),
                              ),
                            ],
                          ),
                          trailing: Wrap(
                            children: const [
                              Text(
                                '1,529K',
                                style: TextStyle(
                                    fontFamily: FontPicker.semibold,
                                    color: ColorPicker.danger,
                                    fontSize: 22),
                              ),
                            ],
                          )),
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
