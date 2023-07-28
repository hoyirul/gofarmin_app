import 'package:flutter/material.dart';
import 'package:gofarmin_app/controllers/agriculture_gov/member_controller.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/button_monitoring_component.dart';
import 'package:gofarmin_app/screens/agriculture_gov/monitorings/detail_farm_screen.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';

class AvailabilityMonitoringAgricutureGovScreen extends StatefulWidget {
  final int id;
  const AvailabilityMonitoringAgricutureGovScreen(
      {super.key, required this.id});

  @override
  State<AvailabilityMonitoringAgricutureGovScreen> createState() =>
      _AvailabilityMonitoringAgricutureGovScreenState();
}

class _AvailabilityMonitoringAgricutureGovScreenState
    extends State<AvailabilityMonitoringAgricutureGovScreen> {
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
                      'Ketersediaan Kambing',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold,
                          color: ColorPicker.dark,
                          fontSize: 18),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Expanded(
                        child: InkWell(
                      child: ButtonMonitoringComponent(
                        text: 'Hewan Sakit \n 10 Kambing',
                        height: 100,
                        bg: ColorPicker.yellow,
                        textColor: ColorPicker.dark,
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                      child: ButtonMonitoringComponent(
                        text: 'Hewan Sehat \n 60 Kambing',
                        height: 100,
                        bg: ColorPicker.yellow,
                        textColor: ColorPicker.dark,
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Expanded(
                        child: InkWell(
                      child: ButtonMonitoringComponent(
                        text: 'Ketersediaan \n 70 Kambing',
                        height: 100,
                        bg: ColorPicker.yellow,
                        textColor: ColorPicker.dark,
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                      child: ButtonMonitoringComponent(
                        text: 'Persentase Hewan Sehat 86%',
                        height: 100,
                        bg: ColorPicker.yellow,
                        textColor: ColorPicker.dark,
                      ),
                    )),
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
