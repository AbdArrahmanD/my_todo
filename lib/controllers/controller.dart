import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_todo/controllers/theme_controller.dart';

class HomeController extends GetxController {
  Rx<ThemeMode> theme =
      ThemeController().loadTheme() ? ThemeMode.dark.obs : ThemeMode.light.obs;
  updateTheme(bool isDarkMode) {
    theme.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    update();
  }
}
