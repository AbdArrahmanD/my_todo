import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_todo/models/task.dart';
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
      body: Column(
        children: [
          addtaskBar(),
          dateBar(context),
          showTasks(),
        ],
      ),
    );
  }

  Container addtaskBar() => Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 10),
        child: Row(
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
        ),
      );

  dateBar(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 9, bottom: 9, left: 20, right: 25),
        child: DatePicker(
          DateTime.now(),
          height: 100,
          width: 70,
          selectionColor: primaryClr,
          selectedTextColor: white,
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

  Obx showTasks() {
    return Obx(
      () => Expanded(
          child: taskController.tasksList.isEmpty
              ? noTaskYet()
              : ListView.builder(
                  itemCount: taskController.tasksList.length,
                  scrollDirection:
                      SizeConfig.orientation == Orientation.landscape
                          ? Axis.horizontal
                          : Axis.vertical,
                  itemBuilder: (context, index) {
                    Task task = taskController.tasksList[index];
                    return AnimationConfiguration.staggeredList(
                      duration: const Duration(milliseconds: 400),
                      position: index,
                      child: SlideAnimation(
                        horizontalOffset: 300,
                        child: FadeInAnimation(
                          child: GestureDetector(
                              onTap: () {
                                showButtomSheet(
                                    task,
                                    task.color == 0
                                        ? primaryClr
                                        : task.color == 1
                                            ? pinkClr
                                            : orangeClr);
                              },
                              child: TaskTile(task: task)),
                        ),
                      ),
                    );
                  })),
    );
  }

  Container noTaskYet() => Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

  showButtomSheet(Task task, Color tileColor) => Get.bottomSheet(Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        width: SizeConfig.screenWidth,
        height: SizeConfig.orientation == Orientation.portrait
            ? SizeConfig.screenHeight * 0.39
            : SizeConfig.screenHeight * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: tileColor.withOpacity(0.8),
        ),
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth / 3,
              height: 5,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: getColor(
                  lightColor: Colors.grey,
                  darkColor: white,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 15),
                    modelSheetButton(
                        label:
                            task.isCompleted == 0 ? 'Complete' : 'Not Complete',
                        onTap: () {
                          Get.back();
                        },
                        color: Colors.grey[600]!),
                    const SizedBox(height: 7),
                    modelSheetButton(
                        label: 'Delete',
                        onTap: () {
                          Get.back();
                        },
                        color: Colors.grey[600]!),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: const Divider(
                        color: white,
                      ),
                    ),
                    modelSheetButton(
                        label: 'Cancel',
                        onTap: () {
                          Get.back();
                        },
                        color: Colors.grey[600]!),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));

  modelSheetButton({
    required String label,
    required Function() onTap,
    required Color color,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: SizeConfig.screenWidth * 0.9,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(
            child: Text(
              label,
              style: titleStyle(color: white),
            ),
          ),
        ),
      );
}
