import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import '../../models/themes.dart';
import '../../services/notification_services.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String startTime = DateFormat('hh:mm a').format(DateTime.now());

  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)));

  int selectedRemind = 5;

  List<int> remindList = [5, 10, 15, 20];

  String selectedRepeat = 'None';

  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyApp().appBar(context, 1, title: 'Add Task'),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: SingleChildScrollView(
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
                  controller: titleController,
                ),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(selectedDate),
                  widget: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                    ),
                    onPressed: () {},
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
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: endTime,
                        widget: IconButton(
                          icon: const Icon(Icons.access_alarm_rounded),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                InputField(
                    title: 'Remind',
                    hint: '$selectedRemind min early',
                    widget: DropdownButton(
                      items: remindList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
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
                colorPicker()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget colorPicker() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
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
            MyButton(
                label: 'Add Task',
                onTap: () async {
                  await NotificationService().setNotificationAfterDuration(
                    1,
                    'Title',
                    'body',
                    const Duration(seconds: 3),
                  );

                  await NotificationService()
                      .displayNotification(title: 'Title', body: 'body');
                  Get.back();
                }),
          ],
        ),
      );
}
