class Task {
  int? id;
  String? note;
  late int color;
  late int isCompleted;
  late String title;
  late String startTime;
  late String endTime;
  late String date;
  late int remind;
  late String repeat;
  Task({
    this.id,
    this.note,
    required this.color,
    required this.isCompleted,
    required this.title,
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

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    color = json['color'];
    isCompleted = json['isCompleted'];
    note = json['note'].toString();
    startTime = json['startTime'];
    endTime = json['endTime'];
    date = json['date'];
    remind = json['remind'];
    repeat = json['repeat'];
  }
}
