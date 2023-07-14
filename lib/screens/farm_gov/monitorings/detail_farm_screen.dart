import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_monitoring_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/farm_gov/home/home_screen.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';

class DetailFarmFarmGovScreen extends StatefulWidget {
  const DetailFarmFarmGovScreen({super.key});

  @override
  State<DetailFarmFarmGovScreen> createState() =>
      _DetailFarmFarmGovScreenState();
}

class _DetailFarmFarmGovScreenState extends State<DetailFarmFarmGovScreen> {
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
                Row(
                  children: const [
                    Expanded(
                        child: InkWell(
                      child: ButtonMonitoringComponent(
                        text: 'Monitoring Peternakan',
                        height: 100,
                        bg: ColorPicker.primary,
                        textColor: ColorPicker.white,
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                      child: ButtonMonitoringComponent(
                        text: 'Monitoring Tempat Ternak',
                        height: 100,
                        bg: ColorPicker.primary,
                        textColor: ColorPicker.white,
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
                        text: 'Monitoring Hewan Ternak',
                        height: 100,
                        bg: ColorPicker.primary,
                        textColor: ColorPicker.white,
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                      child: ButtonMonitoringComponent(
                        text: 'Cek Kelayakan Peternakan',
                        height: 100,
                        bg: ColorPicker.primary,
                        textColor: ColorPicker.white,
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
                        text: 'Check Status',
                        height: 60,
                        bg: ColorPicker.greyLight,
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
