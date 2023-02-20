import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'TaskModel.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  TaskStatus status;
  @HiveField(3)
  DateTime? createdAt;
  @HiveField(4)
  DateTime? startedAt;
  @HiveField(5)
  DateTime? completedAt;
  @HiveField(6)
  int timeSpent;

  // @HiveField(6)
  // UserModel? user;

  TaskModel(
      {required this.id,
      this.title = '',
      this.status = TaskStatus.TODO,
      this.completedAt,
      this.timeSpent = 0,
      this.createdAt,
      this.startedAt,
      // this.user,
      Key? key});

  int get getSpentTime {
    if (startedAt == null) return timeSpent;
    return DateTimeRange(start: startedAt!, end: DateTime.now())
            .duration
            .inMilliseconds +
        timeSpent;
  }
}

@HiveType(typeId: 1)
enum TaskStatus {
  @HiveField(0)
  TODO,
  @HiveField(1)
  IN_PROGRESS,
  @HiveField(2)
  DONE
}
