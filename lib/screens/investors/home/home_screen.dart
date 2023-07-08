import 'package:flutter_svg/flutter_svg.dart';
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

class HomeInvestorScreen extends StatefulWidget {
  const HomeInvestorScreen({super.key});

  @override
  State<HomeInvestorScreen> createState() => _HomeInvestorScreenState();
}

class _HomeInvestorScreenState extends State<HomeInvestorScreen> {
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
                height: 260,
                color: Colors.transparent,
              ),
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
                top: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: profileController.getName(),
                      builder: (context, snapshot) {
                        return Text(
                          'Hi, ${snapshot.data}',
                          style: const TextStyle(
                              fontFamily: FontPicker.semibold,
                              fontSize: 16,
                              color: ColorPicker.white),
                        );
                      },
                    ),
                    FutureBuilder(
                      future: profileController.getEmail(),
                      builder: (context, snapshot) {
                        return Text(
                          '${snapshot.data}',
                          style: const TextStyle(
                              fontFamily: FontPicker.regular,
                              fontSize: 11,
                              color: ColorPicker.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 80,
                right: 25,
                child: ButtonComponent(
                  button: TextButton(
                    onPressed: () {
                      authController.logout();
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold,
                          fontSize: 12,
                          color: ColorPicker.primary),
                    ),
                  ),
                  colors: ColorPicker.white,
                  height: 40,
                  width: 120,
                ),
              ),
              Positioned(
                top: 150,
                left: 25,
                right: 25,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 25, right: 25),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorPicker.white,
                      boxShadow: const [
                        BoxShadow(
                            color: ColorPicker.greyLight,
                            offset: Offset(0, 1),
                            blurRadius: 1)
                      ]),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                print('Booking');
                              },
                              child: const HomeFeatureComponent(
                                  icons: 'assets/icons/majestic.svg',
                                  title: 'Portofolio'))),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                print('Transaction');
                              },
                              child: const HomeFeatureComponent(
                                  icons: 'assets/icons/mingcute.svg',
                                  title: 'Transactions'))),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                print('Account');
                              },
                              child: const HomeFeatureComponent(
                                  icons: 'assets/icons/account.svg',
                                  title: 'Account'))),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
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
                      'What is new?',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold,
                          color: ColorPicker.dark,
                          fontSize: 18),
                    )),
                const SizedBox(
                  height: 15,
                ),
                const BannerComponent(),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Investments',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold,
                          color: ColorPicker.dark,
                          fontSize: 18),
                    )),
                const SizedBox(
                  height: 10,
                ),
                GridView.count(
                  padding: const EdgeInsets.all(0),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  childAspectRatio: (4 / 5),
                  shrinkWrap: true,
                  children: const [
                    MemberListComponent(),
                    MemberListComponent(),
                    MemberListComponent(),
                    MemberListComponent(),
                    MemberListComponent(),
                    MemberListComponent(),
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
