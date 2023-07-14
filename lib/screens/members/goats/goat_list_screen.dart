import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/goat_list_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/members/goats/add_goat_screen.dart';
import 'package:gofarmin_app/screens/members/goats/edit_goat_screen.dart';
import 'package:gofarmin_app/screens/members/home/home_screen.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';

class GoatListMemberScreen extends StatefulWidget {
  const GoatListMemberScreen({super.key});

  @override
  State<GoatListMemberScreen> createState() => _GoatListMemberScreenState();
}

class _GoatListMemberScreenState extends State<GoatListMemberScreen> {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const AddGoatMemberScreen(),
                transition: Transition.circularReveal);
          },
          backgroundColor: ColorPicker.primary,
          child: const Icon(Icons.add),
        ),
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
                        '${HttpHelper().url}/images/members/member4.jpg',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 25,
                    child: InkWell(
                      onTap: () => Get.to(const HomeMemberScreen(),
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
                                Get.to(const EditGoatMemberScreen(),
                                    transition: Transition.circularReveal);
                              },
                              child: const Text(
                                'Edit Data',
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
                                // Get.to(const DetailGoatInvestorScreen(),
                                //     transition: Transition.native);
                                print('Test');
                              },
                              child: const Text(
                                'Edit Data',
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
