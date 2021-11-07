import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_todo/views/pages/notification_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
        primaryColor: Colors.teal,
        backgroundColor: Colors.teal,
      ),
      title: 'ToDo',
      debugShowCheckedModeBanner: false,
      home: NotificationScreen(),
    );
  }
}
