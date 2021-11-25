import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  RxList<Task> tasksList = [
    Task(
      id: 1,
      color: 0,
      isCompleted: 0,
      title: 'Title',
      note:
          'Excepteur occaecat laborum adipisicing elit sint eiusmod velit duis ex cillum. Laborum excepteur incididunt irure consectetur labore. Occaecat occaecat tempor ipsum non. Quis pariatur non sit ex. Officia minim aute consequat eiusmod. Ex aute mollit est aliquip anim laborum aliqua sit tempor nostrud cupidatat.',
      startTime: DateFormat('hh:mm a').format(DateTime.now()),
      endTime: '03:08',
      date: '20/10',
      remind: 5,
      repeat: '',
    ),
    Task(
      id: 2,
      color: 1,
      isCompleted: 1,
      title: 'Title2',
      note: 'Irure pariatur commodo aute consequat minim et.',
      startTime: DateFormat('hh:mm a').format(DateTime.now()),
      endTime: '03:08',
      date: '20/10',
      remind: 5,
      repeat: '',
    ),
    Task(
      id: 2,
      color: 2,
      isCompleted: 1,
      title: 'Title2',
      note:
          'Ut eu aliqua ad aute aliquip reprehenderit in qui. Ipsum quis nulla anim cupidatat aliquip qui dolore tempor amet dolor duis. Do mollit ea dolore laborum.',
      startTime: DateFormat('hh:mm a')
          .format(DateTime.now().add(const Duration(minutes: 1))),
      endTime: '03:08',
      date: '20/10',
      remind: 5,
      repeat: '',
    ),
  ].obs;
  addTask({required Task task}) {}
}
