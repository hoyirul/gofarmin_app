import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/investors/goat_controller.dart';
import 'package:gofarmin_app/controllers/investors/member_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/goat_list_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/investors/home/home_screen.dart';
import 'package:gofarmin_app/screens/investors/invests/detail_goat_screen.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:intl/intl.dart' as intl;

class DetailMemberInvestorScreen extends StatefulWidget {
  final int id;
  const DetailMemberInvestorScreen({super.key, required this.id});

  @override
  State<DetailMemberInvestorScreen> createState() =>
      _DetailMemberInvestorScreenState();
}

class _DetailMemberInvestorScreenState
    extends State<DetailMemberInvestorScreen> {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  MemberController memberController = Get.put(MemberController());
  GoatController goatController = Get.put(GoatController());

  @override
  Widget build(BuildContext context) {
    goatController.setMemberId('${widget.id}');
    final members = memberController.getById(widget.id);
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
                Align(
                    alignment: Alignment.centerLeft,
                    child: FutureBuilder(
                      future: members,
                      builder: (context, snapshot) {
                        return Text(
                          '${snapshot.data?.name}',
                          style: const TextStyle(
                              fontFamily: FontPicker.bold,
                              color: ColorPicker.dark,
                              fontSize: 22),
                        );
                      },
                    )),
                const SizedBox(
                  height: 8,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: FutureBuilder(
                      future: members,
                      builder: (context, snapshot) {
                        return Text(
                          '${snapshot.data?.address}',
                          style: const TextStyle(
                              fontFamily: FontPicker.regular,
                              color: ColorPicker.primary,
                              fontSize: 12),
                        );
                      },
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
                // Row(
                //   children: const [
                //     Expanded(
                //         child: TabButtonComponent(
                //       text: 'Jantan',
                //       colors: ColorPicker.primary,
                //     )),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Expanded(
                //         child: TabButtonComponent(
                //       text: 'Betina',
                //       colors: ColorPicker.grey,
                //     )),
                //   ],
                // ),
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
                                Get.to(DetailGoatInvestorScreen(goatId: row.id),
                                    transition: Transition.native);
                              },
                              child: const Text(
                                'Invest Now',
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
