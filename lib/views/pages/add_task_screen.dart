import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/task_controller.dart';
import '../../main.dart';
import '../../models/task.dart';
import '../../models/themes.dart';
import '../../services/notification_services.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskScreen extends StatefulWidget {
  final DateTime oldDate;
  const AddTaskScreen(this.oldDate, {Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TaskController taskController = Get.put(TaskController());

  final TextEditingController titleController = TextEditingController();

  final TextEditingController noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String startTime = DateFormat('hh:mm a').format(DateTime.now());

  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)));

  int selectedRemind = 5;

  List<int> remindList = [0, 5, 10, 15, 20];

  String selectedRepeat = 'None';

  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MyApp().appBar(context, 1, title: 'Add New Task'),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                InputField(
                  title: 'Title',
                  hint: 'Add Title here',
                  controller: titleController,
                ),
                InputField(
                  title: 'Note',
                  hint: 'Add Note here',
                  controller: noteController,
                ),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(selectedDate),
                  widget: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                    ),
                    onPressed: () => pickDate(),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: startTime,
                        widget: IconButton(
                          icon: const Icon(Icons.access_alarm_rounded),
                          onPressed: () => pickTime(true),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: endTime,
                        widget: IconButton(
                          icon: const Icon(Icons.access_alarm_rounded),
                          onPressed: () => pickTime(false),
                        ),
                      ),
                    ),
                  ],
                ),
                InputField(
                    title: 'Remind',
                    hint: selectedRemind == 0
                        ? 'None'
                        : '$selectedRemind min early',
                    widget: DropdownButton(
                      items: remindList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e == 0 ? 'None' : '$e min',
                                style: const TextStyle(color: white),
                              ),
                            ),
                          )
                          .toList(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 32,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: Colors.blueGrey,
                      style: subTitleStyle(),
                      onChanged: (newVal) {
                        setState(() {
                          selectedRemind = newVal as int;
                        });
                      },
                      underline: Container(height: 0),
                    )),
                InputField(
                    title: 'Repeat',
                    hint: selectedRepeat,
                    widget: DropdownButton(
                      items: repeatList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(color: white),
                              ),
                            ),
                          )
                          .toList(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 32,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: Colors.blueGrey,
                      style: subTitleStyle(),
                      onChanged: (newVal) {
                        setState(() {
                          selectedRepeat = newVal as String;
                        });
                      },
                      underline: Container(height: 0),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    colorPicker(),
                    MyButton(label: 'Add Task', onTap: () => validation())
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validation() {
    if (titleController.text.isNotEmpty) {
      addTasktoDb();
      Get.back();
    } else {
      Get.snackbar(
        'Field Required',
        'Title field must be filled',
        duration: const Duration(seconds: 2),
        backgroundColor: getColor(
          lightColor: Colors.grey[300]!,
          darkColor: white,
        ),
        colorText: Colors.red,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 8),
      );
    }
  }

  addTasktoDb() async {
    try {
      String day = selectedDate.toString().split(' ')[0];
      selectedDate = DateTime.parse(day);
      startTime = startTime.split(' ')[0];
      String hour = startTime.split(':')[0];
      String minutes = startTime.split(':')[1];

      selectedDate = selectedDate.add(Duration(
        hours: int.parse(hour),
        minutes: int.parse(minutes),
      ));

      await taskController
          .insertTask(
              task: Task(
        color: selectedColor,
        isCompleted: 0,
        title: titleController.text,
        note: noteController.text,
        startTime: startTime,
        endTime: endTime,
        date: DateFormat.yMd().format(selectedDate),
        remind: selectedRemind,
        repeat: selectedRepeat,
      ))
          .then((value) {
        NotifyHelper().scheduledNotification(
          hour: int.parse(hour),
          minutes: int.parse(minutes),
          task: Task(
            id: value,
            color: selectedColor,
            isCompleted: 0,
            title: titleController.text,
            note: noteController.text,
            startTime: startTime,
            endTime: endTime,
            date: DateFormat.yMd().format(selectedDate),
            remind: selectedRemind,
            repeat: selectedRepeat,
          ),
        );
        debugPrint('task is ready');
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget colorPicker() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Text('Choose Color', style: titleStyle()),
            Row(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = index;
                            });
                          },
                          child: CircleAvatar(
                            child: selectedColor == index
                                ? const Icon(Icons.done)
                                : null,
                            backgroundColor: index == 0
                                ? primaryClr
                                : index == 1
                                    ? pinkClr
                                    : orangeClr,
                          ),
                        ),
                      )),
            ),
          ],
        ),
      );

  pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null)
      setState(() => selectedDate = pickedDate);
    else
      debugPrint('Something went wrong');
  }

  pickTime(bool isStartTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      setState(() {
        isStartTime ? startTime = formattedTime : endTime = formattedTime;
      });
    }
  }
}
