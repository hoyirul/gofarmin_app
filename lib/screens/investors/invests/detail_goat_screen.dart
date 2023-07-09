import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_alert_component.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/confirm_dialog_component.dart';
import 'package:gofarmin_app/screens/components/input_component.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:gofarmin_app/screens/investors/invests/detail_member_screen.dart';
import 'package:gofarmin_app/screens/investors/invests/payment_screen.dart';

class DetailGoatInvestorScreen extends StatefulWidget {
  const DetailGoatInvestorScreen({super.key});

  @override
  State<DetailGoatInvestorScreen> createState() =>
      _DetailGoatInvestorScreenState();
}

class _DetailGoatInvestorScreenState extends State<DetailGoatInvestorScreen> {
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
                      BorderRadius.only(bottomRight: Radius.circular(50)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  child: Image.network(
                    'http://192.168.1.13:8000/images/members/member3.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 25,
                child: InkWell(
                  onTap: () => Get.to(const DetailMemberInvestorScreen(),
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
                      'kambing Kacang',
                      style: TextStyle(
                          fontFamily: FontPicker.bold,
                          color: ColorPicker.dark,
                          fontSize: 22),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: '1,299K',
                                  style: TextStyle(
                                      fontFamily: FontPicker.bold,
                                      color: ColorPicker.primary,
                                      fontSize: 30)),
                              TextSpan(
                                  text: ' / item',
                                  style: TextStyle(
                                      fontFamily: FontPicker.medium,
                                      color: ColorPicker.danger,
                                      fontSize: 16)),
                            ]),
                          )),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Age <> 3 months',
                          style: TextStyle(
                              color: ColorPicker.grey,
                              fontFamily: FontPicker.medium,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lorem ipsum, atau ringkasnya lipsum, adalah teks standar yang ditempatkan untuk mendemostrasikan elemen grafis atau presentasi visual seperti font, tipografi, dan tata letak',
                      style: TextStyle(
                          fontFamily: FontPicker.regular,
                          color: ColorPicker.grey,
                          fontSize: 12),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const LabelComponent(label: 'Qty of Goat'),
                const SizedBox(
                  height: 5,
                ),
                const InputComponent(
                    hintText: 'Qty of goat',
                    obscuredText: false,
                    colors: ColorPicker.greyAccent),
                const SizedBox(
                  height: 20,
                ),
                ButtonComponent(
                    height: 50,
                    width: double.infinity,
                    colors: ColorPicker.primary,
                    button: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmDialogComponent(
                                message: 'Are you sure?',
                                confirm: InkWell(
                                    onTap: () => Get.to(
                                        const PaymentInvestorScreen(),
                                        transition: Transition.circularReveal),
                                    child: const ButtonAlertComponent(
                                      text: 'Continue',
                                      colors: ColorPicker.primary,
                                    )),
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Continue Invest',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontPicker.bold,
                              color: ColorPicker.white),
                        ))),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
