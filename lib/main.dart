import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_todo/controllers/controller.dart';

import 'controllers/theme_controller.dart';
import 'models/themes.dart';
import 'views/pages/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: controller.theme.value,
        title: 'ToDo',
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }

  AppBar appBar(int n, {String? title}) => AppBar(
        leading: IconButton(
          icon: n == 0
              ? Obx(
                  () => Icon(
                    controller.theme.value == ThemeMode.dark
                        ? Icons.wb_sunny_outlined
                        : Icons.mode_night,
                    color: controller.theme.value == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                )
              : Obx(
                  () => Icon(
                    Icons.arrow_back,
                    color: controller.theme.value == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
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
}
