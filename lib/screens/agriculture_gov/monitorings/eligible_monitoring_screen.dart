import 'package:flutter/material.dart';
import 'package:gofarmin_app/controllers/agriculture_gov/member_controller.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/agriculture_gov/monitorings/detail_farm_screen.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';

class EligibleMonitoringAgricultureGovScreen extends StatefulWidget {
  final int id;
  const EligibleMonitoringAgricultureGovScreen({super.key, required this.id});

  @override
  State<EligibleMonitoringAgricultureGovScreen> createState() =>
      _EligibleMonitoringAgricultureGovScreenState();
}

class _EligibleMonitoringAgricultureGovScreenState
    extends State<EligibleMonitoringAgricultureGovScreen> {
  MemberController memberController = Get.put(MemberController());
  List<TimelineItem> items = [
    TimelineItem(title: "Komposisi Nutrisi", isCompleted: true),
    TimelineItem(title: "Kualitas Bahan Baku", isCompleted: true),
    TimelineItem(title: "Pencampuran Pakan Ternak", isCompleted: true),
    TimelineItem(title: "Kelembapan dan Kehalusan", isCompleted: true),
    TimelineItem(title: "Sumber Pangan Alternatif", isCompleted: true),
    TimelineItem(title: "Kadar Aflatoksin", isCompleted: true),
    TimelineItem(title: "Kebersihan dan Sanitasi", isCompleted: true),
    TimelineItem(title: "Pemanfaatan dan Efisiensi", isCompleted: true),
  ];

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
                      'Cek Kelayakan Pakan',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold,
                          color: ColorPicker.dark,
                          fontSize: 18),
                    )),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TimelineTile(
                      title: items[index].title,
                      isChecked: items[index].isCompleted,
                      onChecked: (value) {
                        setState(() {
                          items[index].isCompleted = value;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class TimelineItem {
  String title;
  bool isCompleted;

  TimelineItem({required this.title, this.isCompleted = false});
}

class TimelineTile extends StatelessWidget {
  final String title;
  final bool isChecked;
  final ValueChanged<bool>? onChecked;

  const TimelineTile(
      {super.key,
      required this.title,
      required this.isChecked,
      this.onChecked});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      shadowColor: ColorPicker.greyAccent,
      child: ListTile(
        trailing: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isChecked ? Colors.green : Colors.orange,
          ),
          child: isChecked
              ? const Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
        ),
        title: Text(title),
        onTap: () {
          if (onChecked != null) {
            onChecked!(!isChecked);
          }
        },
      ),
    );
  }
}
