import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  GetStorage box = GetStorage();
  final key = 'isDarkMode';
  bool loadTheme() {
    print('loadTheme : ${box.read<bool>(key)}');
    return box.read<bool>(key) ?? false;
  }

  void saveTheme(bool data) {
    box.write(key, data);
  }

  late Rx<ThemeMode> theme =
      loadTheme() ? ThemeMode.dark.obs : ThemeMode.light.obs;
  updateTheme() {
    saveTheme(!loadTheme());
    theme.value = loadTheme() ? ThemeMode.dark : ThemeMode.light;
    update();
  }
}
