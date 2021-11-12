import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';
import 'add_task_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(0),
      body: Center(
        child: Column(
          children: [
            MyButton(
              label: 'Add Task',
              onTap: () {
                Get.to(() => const AddTaskScreen());
              },
            ),
            const SizedBox(height: 10),
            MyButton(
              label: 'Notification Screen',
              onTap: () {
                Get.to(() => const NotificationScreen(
                      payLoad:
                          'Title |Deserunt tempor velit cupidatat nisi do anim elit proident reprehenderit. Enim id do eu eiusmod magna ut magna eiusmod quis reprehenderit pariatur et ea. Eiusmod cillum culpa qui est. Commodo veniam nulla ipsum incididunt eu consectetur. Reprehenderit esse ullamco deserunt duis Lorem non nostrud laborum sit ex adipisicing aliqua. Fugiat nulla pariatur Lorem reprehenderit est in dolore anim officia nulla ad sint nulla sit. Sit tempor est quis qui dolore eu incididunt ex.|20/10',
                    ));
              },
            ),
            const InputField(
              title: 'Title',
              hint: 'Enter Title Here.',
              widget: Icon(Icons.calendar_today_outlined),
            )
          ],
        ),
      ),
    );
  }
}
