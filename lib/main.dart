import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/theme_controller.dart';
import 'db/db_services.dart';
import 'models/themes.dart';
import 'services/notification_services.dart';
import 'views/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await DbServices.init();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeController controller = Get.put(ThemeController());

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

  AppBar appBar(BuildContext context, int n, {String? title}) => AppBar(
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 7),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/person.jpeg'),
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: n == 0
              ? Obx(
                  () => Icon(
                    Icons.dark_mode,
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
              controller.updateTheme();
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
