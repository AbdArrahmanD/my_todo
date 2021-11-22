import 'package:flutter/material.dart';

import '../../models/size_config.dart';
import '../../models/task.dart';
import '../../models/themes.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({
    required this.task,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: SizeConfig.orientation == Orientation.portrait
          ? const EdgeInsets.only(bottom: 8, right: 20, left: 20)
          : const EdgeInsets.only(right: 7, left: 7),
      padding: const EdgeInsets.all(8.0),
      width: SizeConfig.orientation == Orientation.portrait
          ? double.infinity
          : getProportionateScreenWidth(150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: getTaskColor(task.color),
      ),
      child: Row(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: titleStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${task.startTime} - ${task.endTime}',
                      style: bodyStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  task.note,
                  style: subTitleStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[100],
                  ),
                )
              ],
            ),
          )),
          Container(
            height: 60,
            width: 0.5,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted == 0 ? 'ToDo' : 'Completed',
              style: bodyStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  getTaskColor(int color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
}
