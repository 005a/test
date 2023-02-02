import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:test/models/CardModel.dart';
import 'package:flutter/material.dart';
import 'package:test/models/TaskStatusModel.dart';

class TaskProvider with ChangeNotifier {
  List<CardModel> _taskList = [];
  List<CardModel> get taskList => _taskList;

  void addCard() {
    int newid = _taskList.isEmpty ? 1 : 1 + _taskList.last.id;
    _taskList.add(CardModel(id: newid, title: 'New card $newid'));
    updateState();
  }

  void removeCard(CardModel card) {
    _taskList = ([..._taskList..removeWhere((element) => element == card)]);
    updateState();
  }

  void editCard(CardModel card) {
    if (card.status.name == TaskStatus.DONE && card.completedAt != null) {
      card.completedAt = DateTime.now();
    }
    _taskList =
        ([..._taskList..removeWhere((element) => element.id == card.id), card]);
    updateState();
  }

  void exportCSV() {
    // csvsave
    updateState();
  }

  updateState() {
    // Box tasks = Hive.box('tasks');
    // var t = _taskList.map((element) => jsonEncode(element.toJson())).toList();
    // tasks.put('all', t);
    notifyListeners();
  }
}
