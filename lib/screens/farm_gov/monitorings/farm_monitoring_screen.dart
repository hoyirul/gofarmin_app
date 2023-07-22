import 'package:flutter/material.dart';

class FarmMonitoringFarmGovScreen extends StatefulWidget {
  const FarmMonitoringFarmGovScreen({super.key});

  @override
  State<FarmMonitoringFarmGovScreen> createState() =>
      _FarmMonitoringFarmGovScreenState();
}

class _FarmMonitoringFarmGovScreenState
    extends State<FarmMonitoringFarmGovScreen> {
  List<TimelineItem> items = [
    TimelineItem(title: "Langkah 1", isCompleted: true),
    TimelineItem(title: "Langkah 2", isCompleted: false),
    TimelineItem(title: "Langkah 3", isCompleted: true),
    TimelineItem(title: "Langkah 4", isCompleted: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
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
    );
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
    return ListTile(
      leading: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isChecked ? Colors.green : Colors.red,
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
    );
  }
}
