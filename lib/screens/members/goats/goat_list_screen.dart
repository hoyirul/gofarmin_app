import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/members/goat_controller.dart';
import 'package:gofarmin_app/controllers/members/member_controller.dart';
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
import 'package:intl/intl.dart' as intl;

class GoatListMemberScreen extends StatefulWidget {
  const GoatListMemberScreen({super.key});

  @override
  State<GoatListMemberScreen> createState() => _GoatListMemberScreenState();
}

class _GoatListMemberScreenState extends State<GoatListMemberScreen> {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  GoatController goatController = Get.put(GoatController());
  MemberController memberController = Get.put(MemberController());

  @override
  Widget build(BuildContext context) {
    final members = memberController.getById();
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
                      child: FutureBuilder(
                        future: members,
                        builder: (context, snapshot) {
                          if (snapshot.data?.ktp == null) {
                            return Image.network(
                              '${HttpHelper().url}/images/members/default-member.jpg',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fitWidth,
                            );
                          } else {
                            return Image.network(
                              fit: BoxFit.fitWidth,
                              '${HttpHelper().url}/storage/${snapshot.data?.ktp}',
                              width: MediaQuery.of(context).size.width,
                            );
                          }
                        },
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder(
                        future: profileController.getName(),
                        builder: (context, snapshot) => Text(
                          '${snapshot.data}',
                          style: const TextStyle(
                              fontFamily: FontPicker.bold,
                              color: ColorPicker.dark,
                              fontSize: 22),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: FutureBuilder(
                          future: profileController.getAddress(),
                          builder: (context, snapshot) => Text(
                            '${snapshot.data}',
                            style: const TextStyle(
                                fontFamily: FontPicker.regular,
                                color: ColorPicker.primary,
                                fontSize: 12),
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder(
                        future: members,
                        builder: (context, snapshot) {
                          return Text(
                            '${snapshot.data?.description}',
                            style: const TextStyle(
                                fontFamily: FontPicker.regular,
                                color: ColorPicker.grey,
                                fontSize: 12),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      if (goatController.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return GridView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: goatController.goatByMemberList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: (4 / 5)),
                          itemBuilder: (context, index) {
                            final row = goatController.goatByMemberList[index];
                            return GoatListComponent(
                              name: row.goatName,
                              img: row.image,
                              price:
                                  'Rp ${intl.NumberFormat.decimalPattern().format(row.price)}',
                              route: TextButton(
                                  onPressed: () {
                                    Get.to(const EditGoatMemberScreen(),
                                        transition: Transition.native);
                                  },
                                  child: const Text(
                                    'Edit Data',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: FontPicker.semibold,
                                        color: ColorPicker.primary),
                                  )),
                            );
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
