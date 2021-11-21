import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../../controllers/task_controller.dart';
import '../../main.dart';
import '../../models/size_config.dart';
import '../../models/themes.dart';
import '../widgets/button.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    tz.initializeTimeZones();
    super.initState();
  }

  TaskController taskController = Get.put(TaskController());
  DateTime selecedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MyApp().appBar(context, 0, title: 'To Do'),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            addtaskBar(),
            dateBar(context),
            showTasks(),
          ],
        ),
      ),
    );
  }

  Row addtaskBar() => Row(
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
          dateTextStyle: subHeadingStyle(
              size: 24, color: Colors.grey, fontWeight: FontWeight.w600),
          dayTextStyle: subHeadingStyle(
              size: 16, color: Colors.grey, fontWeight: FontWeight.w600),
          monthTextStyle: subHeadingStyle(
              size: 12, color: Colors.grey, fontWeight: FontWeight.w600),
          onDateChange: (newDate) {
            setState(() {
              selecedDate = newDate;
            });
          },
        ),
      );

  showTasks() {
    return Obx(() => Expanded(
        child: taskController.tasksList.isEmpty
            ? noTaskYet()
            : SingleChildScrollView(
                child: Column(
                  children: taskController.tasksList
                      .map((task) => TaskTile(task: task))
                      .toList(),
                ),
              )));
  }

  noTaskYet() => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: SizeConfig.orientation == Orientation.portrait
              ? Axis.vertical
              : Axis.horizontal,
          children: [
            SvgPicture.asset(
              'assets/images/task.svg',
              height: SizeConfig.screenHeight / 7,
              color: primaryClr,
            ),
            SizeConfig.orientation == Orientation.portrait
                ? SizedBox(height: SizeConfig.screenHeight / 17)
                : SizedBox(width: SizeConfig.screenHeight / 17),
            Text(
              'You Don\'t Have Any Task Yet!\nAdd new Task to make your day Productive',
              style: subTitleStyle(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
