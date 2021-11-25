import 'dart:convert';

class Task {
  int? id;
  int color;
  int isCompleted;
  String title;
  String note;
  String startTime;
  String endTime;
  String date;
  int remind;
  String repeat;
  Task({
    this.id,
    required this.color,
    required this.isCompleted,
    required this.title,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.remind,
    required this.repeat,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color,
      'isCompleted': isCompleted,
      'title': title,
      'note': note,
      'startTime': startTime,
      'endTime': endTime,
      'date': date,
      'remind': remind,
      'repeat': repeat,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      color: map['color'],
      isCompleted: map['isCompleted'],
      title: map['title'],
      note: map['note'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      date: map['date'],
      remind: map['remind'],
      repeat: map['repeat'],
    );
  }

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
