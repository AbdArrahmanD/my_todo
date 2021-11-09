import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_todo/views/widgets/input_field.dart';

import '../../controllers/theme_controller.dart';
import '../widgets/button.dart';
import 'notification_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.change_circle),
          onPressed: () {
            ThemeController().switchThemeMode();
            Get.to(() => NotificationScreen());
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            MyButton(
              label: 'Add Task',
              onTap: () {},
            ),
            InputField(
              title: 'Title',
              hint: 'Enter Title Here.',
              widget: const Icon(Icons.calendar_today_outlined),
            )
          ],
        ),
      ),
    );
  }
}
