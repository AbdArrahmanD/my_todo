import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_todo/views/pages/add_task_screen.dart';

import 'controllers/theme_controller.dart';
import 'models/themes.dart';
import 'views/pages/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeController().theme,
      title: 'ToDo',
      debugShowCheckedModeBanner: false,
      home: const AddTaskScreen(),
    );
  }
}
