import 'package:gofarmin_app/controllers/farm_gov/member_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_alert_component.dart';
import 'package:gofarmin_app/screens/components/button_monitoring_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/confirm_dialog_component.dart';
import 'package:gofarmin_app/screens/farm_gov/home/home_screen.dart';
import 'package:gofarmin_app/screens/farm_gov/monitorings/eligible_monitoring_screen.dart';
import 'package:gofarmin_app/screens/farm_gov/monitorings/farm_monitoring_screen.dart';
import 'package:gofarmin_app/screens/farm_gov/monitorings/goat_monitoring_screen.dart';
import 'package:gofarmin_app/screens/farm_gov/monitorings/pen_monitoring_screen.dart';
import 'package:gofarmin_app/utils/alert_helpers.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';

class DetailFarmFarmGovScreen extends StatefulWidget {
  final int id;
  const DetailFarmFarmGovScreen({super.key, required this.id});

  @override
  State<DetailFarmFarmGovScreen> createState() =>
      _DetailFarmFarmGovScreenState();
}

class _DetailFarmFarmGovScreenState extends State<DetailFarmFarmGovScreen> {
  MemberController memberController = Get.put(MemberController());

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
                  onTap: () => Get.to(const HomeFarmGovScreen(),
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
                      'Monitoring',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold,
                          color: ColorPicker.dark,
                          fontSize: 18),
                    )),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: members,
                  builder: (context, snapshot) => Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          print(snapshot.data?.memberStatus);
                          if (snapshot.data?.memberStatus == 'worthy') {
                            Get.to(FarmMonitoringFarmGovScreen(id: widget.id));
                          } else {
                            AlertHelper().showAlert(
                                'Peternakan masih dalam pengecekan!');
                          }
                        },
                        child: const ButtonMonitoringComponent(
                          text: 'Monitoring Peternakan',
                          height: 100,
                          bg: ColorPicker.primary,
                          textColor: ColorPicker.white,
                        ),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          if (snapshot.data?.memberStatus == 'worthy') {
                            Get.to(PenMonitoringFarmGovScreen(id: widget.id));
                          } else {
                            AlertHelper().showAlert(
                                'Peternakan masih dalam pengecekan!');
                          }
                        },
                        child: const ButtonMonitoringComponent(
                          text: 'Monitoring Tempat Ternak',
                          height: 100,
                          bg: ColorPicker.primary,
                          textColor: ColorPicker.white,
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: members,
                  builder: (context, snapshot) => Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          if (snapshot.data?.memberStatus == 'worthy') {
                            Get.to(GoatMonitoringFarmGovScreen(id: widget.id));
                          } else {
                            AlertHelper().showAlert(
                                'Peternakan masih dalam pengecekan!');
                          }
                        },
                        child: const ButtonMonitoringComponent(
                          text: 'Monitoring Hewan Ternak',
                          height: 100,
                          bg: ColorPicker.primary,
                          textColor: ColorPicker.white,
                        ),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          if (snapshot.data?.memberStatus == 'worthy') {
                            Get.to(
                                EligibleMonitoringFarmGovScreen(id: widget.id));
                          } else {
                            AlertHelper().showAlert(
                                'Peternakan masih dalam pengecekan!');
                          }
                        },
                        child: const ButtonMonitoringComponent(
                          text: 'Cek Kelayakan Peternakan',
                          height: 100,
                          bg: ColorPicker.primary,
                          textColor: ColorPicker.white,
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    FutureBuilder(
                      future: members,
                      builder: (context, snapshot) => Expanded(
                          child: InkWell(
                        onTap: () {
                          if (snapshot.data?.memberStatus == 'worthy') {
                            AlertHelper().showAlert(
                                'Peternakan telah dicek dan peternakan ini dinyatakan layak pada 03 April 2023');
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmDialogComponent(
                                  message:
                                      'Apakah sudah melakukan pengecekan dan apakah peternakan ini layak?',
                                  confirm: InkWell(
                                      onTap: () {
                                        memberController
                                            .updateMemberById(widget.id);
                                      },
                                      child: const ButtonAlertComponent(
                                        text: 'Yes',
                                        colors: ColorPicker.primary,
                                      )),
                                );
                              },
                            );
                          }
                        },
                        child: ButtonMonitoringComponent(
                          text: (snapshot.data?.memberStatus != 'worthy')
                              ? 'Dalam pengecekan'
                              : 'Telah dicek',
                          height: 60,
                          bg: (snapshot.data?.memberStatus != 'worthy')
                              ? ColorPicker.orange
                              : ColorPicker.greyLight,
                          textColor: (snapshot.data?.memberStatus != 'worthy')
                              ? ColorPicker.white
                              : ColorPicker.dark,
                        ),
                      )),
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
