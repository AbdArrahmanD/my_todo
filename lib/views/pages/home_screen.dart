import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_todo/views/pages/add_task_screen.dart';

import '../../main.dart';
import '../../models/themes.dart';
import '../widgets/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selecedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MyApp().appBar(context, 0, title: 'To Do'),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            taskBar(),
            dateBar(context),
          ],
        ),
      ),
    );
  }

  Row taskBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle(),
              ),
              Text(
                'Today',
                style: headingStyle(),
              ),
            ],
          ),
          MyButton(
              label: '+ Add Task',
              onTap: () async {
                await Get.to(() => const AddTaskScreen());
                // addTaskController.getTasks();
              })
        ],
      );

  dateBar(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 9),
        child: DatePicker(
          DateTime.now(),
          height: 100,
          width: 70,
          selectionColor: primaryClr,
          selectedTextColor: Colors.white,
          initialSelectedDate: DateTime.now(),
          dateTextStyle: subHeadingStyle(size: 24, color: Colors.grey),
          dayTextStyle: subHeadingStyle(size: 16, color: Colors.grey),
          monthTextStyle: subHeadingStyle(size: 12, color: Colors.grey),
          onDateChange: (newDate) {
            setState(() {
              selecedDate = newDate;
            });
          },
        ),
      );
}
