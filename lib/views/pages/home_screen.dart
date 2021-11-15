import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_todo/controllers/task_controller.dart';
import 'package:my_todo/models/size_config.dart';
import 'package:my_todo/services/notification_services.dart';
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
  late NotifyHelper notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializationNotification();
    notifyHelper.requestIOSPermission();
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
                notifyHelper.displayNotification(
                    title: 'To Do', body: 'Task Added');
                notifyHelper.schedulerNotification();
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
        child:
            taskController.tasksList.isEmpty ? noTaskYet() : const Center()));
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
