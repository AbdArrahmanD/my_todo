import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      home: const HomeScreen(),
    );
  }
}

AppBar appBar(int n, {String? title}) => AppBar(
      leading: IconButton(
        icon: n == 0
            ? Icon(
                Icons.change_circle,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              )
            : Icon(
                Icons.arrow_back,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
        onPressed: () {
          if (n == 0) {
            ThemeController().switchThemeMode();
          } else {
            Get.back();
          }
        },
      ),
      title: Text(
        title ?? '',
        style: headingStyle,
      ),
    );
