import 'dart:core';

import 'package:flutter/material.dart';
import 'package:test/models/TaskStatusModel.dart';

class Task {
  int id;

  String title;
  TaskStatus status;
  DateTime createdAt = DateTime.now();
  Task({
    required this.id,
    this.title = 'New card',
    this.status = TaskStatus.TODO,
    required this.createdAt,
  });
}

class CardModel {
  int id;

  String title;
  TaskStatus status;
  DateTime? createdAt = DateTime.now();
  DateTime? completedAt;
  int? timeSpent;

  CardModel(
      {required this.id,
      this.title = '',
      this.status = TaskStatus.TODO,
      this.completedAt,
      this.timeSpent,
      this.createdAt,
      Key? key});
  Map<String?, dynamic> toJson() {
    Map<String?, dynamic> result = {
      "id": id,
      "title": title,
      "status": status.name,
      "createdAt": createdAt,
      "completedAt": completedAt,
      "timeSpent": timeSpent
    };

    return result;
  }

  factory CardModel.fromJson(Map<String, dynamic> responseData) {
    try {
      return CardModel(
          id: responseData['id'],
          title: responseData['title'],
          status: responseData['status'],
          createdAt: responseData['createdAt'],
          completedAt: responseData['completedAt'],
          timeSpent: responseData['timeSpent']);
    } catch (e, s) {
      print(e);

      throw e;
    }
  }
}
