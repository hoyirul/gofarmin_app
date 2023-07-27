// setelah dashboard bisa langsung ada fitur (monitoring) jadi ketika klik member akan lari ke monitoring
import 'package:gofarmin_app/controllers/agriculture_gov/member_controller.dart';
import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/banner_component.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:gofarmin_app/screens/components/checking_list_component.dart';
import 'package:gofarmin_app/screens/components/circle_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/agriculture_gov/accounts/account_screen.dart';
import 'package:gofarmin_app/screens/agriculture_gov/monitorings/detail_farm_screen.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';

class HomeAgricultureGovScreen extends StatefulWidget {
  const HomeAgricultureGovScreen({super.key});

  @override
  State<HomeAgricultureGovScreen> createState() =>
      _HomeAgricultureGovScreenState();
}

class _HomeAgricultureGovScreenState extends State<HomeAgricultureGovScreen> {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  MemberController memberController = Get.put(MemberController());

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
                height: 160,
                color: Colors.transparent,
              ),
              Container(
                padding: const EdgeInsets.all(0),
                height: 160,
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
                left: -30,
                top: 10,
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
                      Get.to(const AccountAgricultureGovScreen(),
                          transition: Transition.fadeIn);
                    },
                    child: const Text(
                      'Settings',
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
            ],
          ),
          const SizedBox(
            height: 15,
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
                      'Farm List',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold,
                          color: ColorPicker.dark,
                          fontSize: 18),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (memberController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return GridView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: memberController.memberList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (4 / 6),
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        final row = memberController.memberList[index];
                        return InkWell(
                            onTap: () {
                              Get.off(DetailFarmAgricultureGovScreen(
                                id: row.id,
                              ));
                            },
                            child: CheckingListComponent(
                              name: row.name,
                              address: row.address,
                              img: (row.ktp == null)
                                  ? '${HttpHelper().url}/images/members/default-member.jpg'
                                  : row.ktp,
                              status: row.memberStatus,
                            ));
                      },
                    );
                  }
                }),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
