import 'package:get/get.dart';

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
      startTime: '2:54 PM',
      endTime: '03:08 PM',
      date: '20/10',
    ),
    Task(
      id: 2,
      color: 1,
      isCompleted: 1,
      title: 'Title2',
      note: 'Irure pariatur commodo aute consequat minim et.',
      startTime: '2:54 PM',
      endTime: '03:08 PM',
      date: '20/10',
    ),
    Task(
      id: 2,
      color: 2,
      isCompleted: 1,
      title: 'Title2',
      note:
          'Ut eu aliqua ad aute aliquip reprehenderit in qui. Ipsum quis nulla anim cupidatat aliquip qui dolore tempor amet dolor duis. Do mollit ea dolore laborum.',
      startTime: '2:54 PM',
      endTime: '03:08 PM',
      date: '20/10',
    ),
  ].obs;
}
