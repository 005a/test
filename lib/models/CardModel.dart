import 'dart:core';

import 'package:flutter/material.dart';
import 'package:test/models/TaskStatusModel.dart';

class CardModel {
  int id;

  String title;
  TaskStatus status;
  DateTime createdAt = DateTime.now();
  DateTime? completedAt;
  int? timeSpent;

  // CardModel(this.id, this.title, this.status, this.createdAt,
  //     this.completedAt, this.timeSpent);

  CardModel({
    required this.id,
    this.title = 'New card',
    this.status = TaskStatus.TODO,
    this.completedAt,
    this.timeSpent,
  });
}
