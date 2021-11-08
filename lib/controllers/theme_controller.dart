import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController {
  GetStorage box = GetStorage();
  final key = 'isDarkMode';

  bool loadTheme() {
    return box.read<bool>(key) ?? false;
  }

  void saveTheme(bool data) {
    box.write(key, data);
  }

  ThemeMode get theme => loadTheme() ? ThemeMode.dark : ThemeMode.light;

  void switchThemeMode() {
    Get.changeThemeMode(loadTheme() ? ThemeMode.light : ThemeMode.dark);
    saveTheme(!loadTheme());
  }
}
