import 'dart:convert';

Task locationFromJson(String str) => Task.fromJson(json.decode(str));

String locationToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    required this.taskName,
    required this.taskDes,
    required this.taskDueDate,
  });

  String taskName;
  String taskDes;
  String taskDueDate;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskName: json["taskName"],
        taskDes: json["taskDes"],
        taskDueDate: json["taskDueDate"],
      );

  Map<String, dynamic> toJson() => {
        "taskName": taskName,
        "taskDes": taskDes,
        "taskDueDate": taskDueDate,
      };
}
