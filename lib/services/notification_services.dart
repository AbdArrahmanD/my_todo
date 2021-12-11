// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:get/get.dart';
// import 'package:my_todo/models/task.dart';
// import 'package:my_todo/views/pages/notification_screen.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationService {
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }
//   NotificationService._internal();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   String selectedNotificationPayload = '';

//   final BehaviorSubject<String> selectNotificationSubject =
//       BehaviorSubject<String>();

//   initNotification() async {
//     tz.initializeTimeZones();
//     _configureSelectNotificationSubject();
//     await _configureLocalTimeZone();

//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@drawable/ic_stat_check');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsIOS);

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: (String? payload) async {
//         if (payload != null) {
//           debugPrint('notification payload: ' + payload);
//         }
//         selectNotificationSubject.add(payload!);
//       },
//     );
//   }

//   Future<void> setNotificationAfterDuration(
//       {required int id,
//       required String title,
//       String? body,
//       required Duration duration}) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.now(tz.local).add(duration),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'main_channel', 'Main Channel', 'Main channel notifications',
//             importance: Importance.max,
//             priority: Priority.max,
//             icon: '@drawable/ic_stat_check'),
//         iOS: IOSNotificationDetails(
//           sound: 'default.wav',
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//     );
//   }

//   // Future<void> setNotification({
//   //   required int hour,
//   //   required int minutes,
//   //   required Task task,
//   // }) async {
//   //   await flutterLocalNotificationsPlugin.zonedSchedule(
//   //     task.id!, // id may be null when creating task
//   //     task.title,
//   //     task.note,
//   //     _nextInstanceOfTenAM(hour, minutes),
//   //     const NotificationDetails(
//   //       android: AndroidNotificationDetails(
//   //           'main_channel', 'Main Channel', 'Main channel notifications',
//   //           importance: Importance.max,
//   //           priority: Priority.max,
//   //           icon: '@drawable/ic_stat_check'),
//   //       iOS: IOSNotificationDetails(
//   //         sound: 'default.wav',
//   //         presentAlert: true,
//   //         presentBadge: true,
//   //         presentSound: true,
//   //       ),
//   //     ),
//   //     uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.absoluteTime,
//   //     androidAllowWhileIdle: true,
//   //   );
//   // }

//   // Future<void> cancelAllNotifications() async {
//   //   await flutterLocalNotificationsPlugin.cancelAll();
//   // }

//   Future<void> displayNotification(
//       {required String title, required String body}) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         const AndroidNotificationDetails(
//             'your channel id', 'your channel name', 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             icon: '@drawable/ic_stat_check',
//             showWhen: false);
//     IOSNotificationDetails iosPlatformChannelSpecifics =
//         const IOSNotificationDetails();
//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iosPlatformChannelSpecifics,
//     );

//     await flutterLocalNotificationsPlugin.show(
//         0, title, body, platformChannelSpecifics,
//         payload: 'Default_Sound');
//   }

//   scheduledNotification(int hour, int minutes, Task task) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       task.id!,
//       task.title,
//       task.note,
//       //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//       _nextInstanceOfTenAM(hour, minutes),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'your channel id', 'your channel name', 'your channel description'),
//       ),
//       androidAllowWhileIdle: true,

//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//       payload: '${task.title}|${task.note ?? ' '}|${task.startTime}|',
//     );
//   }

//   tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     print('scheduledDate : $scheduledDate');
//     return scheduledDate;
//   }

//   void requestIOSPermissions() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }

//   Future<void> _configureLocalTimeZone() async {
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));
//   }

//   Future onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     Get.dialog(Text(body!));
//   }

//   void _configureSelectNotificationSubject() {
//     selectNotificationSubject.stream.listen((String payload) async {
//       debugPrint('My payload is ' + payload);
//       await Get.to(() => NotificationScreen(
//             payLoad: payload,
//           ));
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '/models/task.dart';
import '../views/pages/notification_screen.dart';

class NotifyHelper {
  late final String localLocation;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String selectedNotificationPayload = '';

  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();
  initializeNotification() async {
    tz.initializeTimeZones();
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_check');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload!);
      },
    );
  }

  displayNotification({required String title, required String body}) async {
    debugPrint('doing test');
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  cancelNotification({required int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  scheduledNotification(
      {required int hour, required int minutes, required Task task}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!,
      task.title,
      task.note,
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      _nextInstanceOfTenAM(
        hour: hour,
        minutes: minutes,
        remind: task.remind,
        repeat: task.repeat,
        date: task.date,
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            channelDescription: 'Main channel notifications',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_stat_check'),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${task.title}|${task.note}|${task.startTime}|',
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM({
    required int hour,
    required int minutes,
    required int remind,
    required String repeat,
    required String date,
  }) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    debugPrint('tz.Local in nextInstanceOfTenAM : ${tz.local}');
    debugPrint('now : $now');
    DateTime formattedDate = DateFormat.yMd().parse(date);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    scheduledDate = remindCalculator(remind, scheduledDate);
    if (scheduledDate.isBefore(now)) {
      if (repeat == 'Daily' || repeat == 'None')
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            formattedDate.add(const Duration(days: 1)).day, hour, minutes);
      else if (repeat == 'Weekly') {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            formattedDate.add(const Duration(days: 7)).day, hour, minutes);
      } else if (repeat == 'Monthly') {
        scheduledDate = tz.TZDateTime(tz.local, now.year,
            (formattedDate.month + 1), formattedDate.day, hour, minutes);
      }
      scheduledDate = remindCalculator(remind, scheduledDate);
    }

    debugPrint('ScheduledDate : $scheduledDate');
    return scheduledDate;
  }

  tz.TZDateTime remindCalculator(int remind, tz.TZDateTime scheduledDate) {
    if (remind == 5)
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 5));
    else if (remind == 10)
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 10));
    else if (remind == 15)
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 15));
    else if (remind == 20)
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 20));
    return scheduledDate;
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    localLocation = timeZoneName;
    debugPrint('timeZoneName : $timeZoneName');
    debugPrint('localLocation : $localLocation');
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    debugPrint('tz.Local in function: ${tz.local}');
  }

//Older IOS
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    Get.dialog(Text(body!));
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('My payload is ' + payload);
      await Get.to(() => NotificationScreen(
            payLoad: payload,
          ));
    });
  }
}
