import 'package:flutter/material.dart';
import 'package:gofarmin_app/controllers/agriculture_gov/member_controller.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/button_monitoring_component.dart';
import 'package:gofarmin_app/screens/agriculture_gov/monitorings/detail_farm_screen.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';

class ProcessedMonitoringAgricutureGovScreen extends StatefulWidget {
  final int id;
  const ProcessedMonitoringAgricutureGovScreen({super.key, required this.id});

  @override
  State<ProcessedMonitoringAgricutureGovScreen> createState() =>
      _ProcessedMonitoringAgricutureGovScreenState();
}

class _ProcessedMonitoringAgricutureGovScreenState
    extends State<ProcessedMonitoringAgricutureGovScreen> {
  MemberController memberController = Get.put(MemberController());
  int persentase = 86;

  @override
  Widget build(BuildContext context) {
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
                  onTap: () => Get.to(
                      DetailFarmAgricultureGovScreen(id: widget.id),
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
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Aneka Olahan Kambing',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold,
                          color: ColorPicker.dark,
                          fontSize: 18),
                    )),
                const SizedBox(
                  height: 15,
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: (4 / 5),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPicker.white,
                        boxShadow: const [
                          BoxShadow(
                              color: ColorPicker.greyLight,
                              offset: Offset(0, 2),
                              blurRadius: 1)
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/olahan/sate.jpg',
                              fit: BoxFit
                                  .cover, // Atur sesuai kebutuhan Anda, bisa juga BoxFit.fill jika ingin memenuhi kotak secara penuh
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: Column(
                              children: const [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Sate Kambing',
                                      style: TextStyle(
                                          fontFamily: FontPicker.semibold,
                                          fontSize: 12),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Sate kambing adalah sate yang terbuat dari potongan',
                                      style: TextStyle(
                                          fontFamily: FontPicker.regular,
                                          fontSize: 10,
                                          color: ColorPicker.grey)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPicker.white,
                        boxShadow: const [
                          BoxShadow(
                              color: ColorPicker.greyLight,
                              offset: Offset(0, 2),
                              blurRadius: 1)
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/olahan/gulai.jpg',
                              fit: BoxFit
                                  .cover, // Atur sesuai kebutuhan Anda, bisa juga BoxFit.fill jika ingin memenuhi kotak secara penuh
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: Column(
                              children: const [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Gulai Kambing',
                                      style: TextStyle(
                                          fontFamily: FontPicker.semibold,
                                          fontSize: 12),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Gulai kambing adalah hidangan khas Indonesia',
                                      style: TextStyle(
                                          fontFamily: FontPicker.regular,
                                          fontSize: 10,
                                          color: ColorPicker.grey)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPicker.white,
                        boxShadow: const [
                          BoxShadow(
                              color: ColorPicker.greyLight,
                              offset: Offset(0, 2),
                              blurRadius: 1)
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/olahan/tongseng.jpg',
                              fit: BoxFit
                                  .cover, // Atur sesuai kebutuhan Anda, bisa juga BoxFit.fill jika ingin memenuhi kotak secara penuh
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: Column(
                              children: const [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Tongseng Kambing',
                                      style: TextStyle(
                                          fontFamily: FontPicker.semibold,
                                          fontSize: 12),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Tongseng adalah hidangan kari khas Indonesia',
                                      style: TextStyle(
                                          fontFamily: FontPicker.regular,
                                          fontSize: 10,
                                          color: ColorPicker.grey)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPicker.white,
                        boxShadow: const [
                          BoxShadow(
                              color: ColorPicker.greyLight,
                              offset: Offset(0, 2),
                              blurRadius: 1)
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/olahan/rendang.jpg',
                              fit: BoxFit
                                  .cover, // Atur sesuai kebutuhan Anda, bisa juga BoxFit.fill jika ingin memenuhi kotak secara penuh
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: Column(
                              children: const [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Rendang Kambing',
                                      style: TextStyle(
                                          fontFamily: FontPicker.semibold,
                                          fontSize: 12),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Rendang adalah hidangan khas Indonesia',
                                      style: TextStyle(
                                          fontFamily: FontPicker.regular,
                                          fontSize: 10,
                                          color: ColorPicker.grey)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
