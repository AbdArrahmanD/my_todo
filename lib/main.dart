import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/task_controller.dart';
import 'controllers/theme_controller.dart';
import 'db/db_services.dart';
import 'models/themes.dart';
import 'services/notification_services.dart';
import 'views/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotifyHelper().initializeNotification();
  NotifyHelper().requestIOSPermissions();
  await DbServices.init();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: themeController.theme.value,
        title: 'ToDo',
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }

  AppBar appBar(BuildContext context, int n, {String? title}) => AppBar(
        centerTitle: true,
        actions: [
          n == 0
              ? IconButton(
                  icon: Obx(
                    () => Icon(
                      Icons.clear_all_outlined,
                      color: themeController.theme.value == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  onPressed: () {
                    taskController.deleteAllTask();
                    NotifyHelper().cancelAllNotification();
                    // HomeScreen.selectedList.clear();
                    // debugPrint('selectedList : ${HomeScreen.selectedList}');
                  },
                )
              : Container(),
          const Padding(
            padding: EdgeInsets.only(right: 7, left: 3),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/person.jpeg'),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: n == 0
              ? Obx(
                  () => Icon(
                    Icons.wb_sunny_outlined,
                    color: themeController.theme.value == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                )
              : Obx(
                  () => Icon(
                    Icons.arrow_back,
                    color: themeController.theme.value == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
          onPressed: () {
            if (n == 0) {
              themeController.updateTheme();
            } else {
              Get.back();
            }
          },
        ),
        title: Text(
          title ?? '',
          style: headingStyle(),
        ),
      );
}
