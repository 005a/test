import 'dart:collection';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:test/models/TaskModel.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _taskList = [];
  List<TaskModel> get taskList => (_taskList);

  Box<TaskModel> tasksBox = Hive.box<TaskModel>('tasks');
  void init() {
    _taskList = tasksBox.values.toList();
    notifyListeners();
  }

  bool isStarting(TaskModel card) {
    return card.status == TaskStatus.IN_PROGRESS && card.startedAt == null;
  }

  void addCard() {
    int newid = _taskList.isEmpty ? 1 : 1 + _taskList.last.id;
    TaskModel newTask = TaskModel(id: newid, title: 'New card $newid');

    tasksBox.put(newid, newTask);
    _taskList.add(newTask);
    updateState();
  }

  void removeCard(TaskModel card) {
    tasksBox.delete(card.id);
    _taskList.removeWhere((element) => element.id == card.id);
    updateState();
  }

  void editCard(TaskModel card) {
    // if done first time - set completed time
    if (card.status == TaskStatus.DONE && card.completedAt == null) {
      card.completedAt = DateTime.now();
    }

    if (card.startedAt == null && card.status == TaskStatus.IN_PROGRESS) {
      card.startedAt = DateTime.now();
    }

    if (card.status != TaskStatus.IN_PROGRESS && card.startedAt != null) {
      card.timeSpent = card.getSpentTime;
      card.startedAt = null;
    }

    tasksBox.put(card.id, card);

    _taskList =
        ([..._taskList..removeWhere((element) => element.id == card.id), card]);

    updateState();
  }

  void exportCSV() {
    // csvsave
//     Map<Permission, PermissionStatus> statuses = await [
//   Permission.storage,
// ].request();

// List<dynamic> associateList = [
//   {"number": 1, "lat": "14.97534313396318", "lon": "101.22998536005622"},
//   {"number": 2, "lat": "14.97534313396318", "lon": "101.22998536005622"},
//   {"number": 3, "lat": "14.97534313396318", "lon": "101.22998536005622"},
//   {"number": 4, "lat": "14.97534313396318", "lon": "101.22998536005622"}
// ];

// List<List<dynamic>> rows = [];

// List<dynamic> row = [];
// row.add("number");
// row.add("latitude");
// row.add("longitude");
// rows.add(row);
// for (int i = 0; i < associateList.length; i++) {
//   List<dynamic> row = [];
//   row.add(associateList[i]["number"] - 1);
//   row.add(associateList[i]["lat"]);
//   row.add(associateList[i]["lon"]);
//   rows.add(row);
// }

// String csv = const ListToCsvConverter().convert(rows);

// String dir = await ExtStorage.getExternalStoragePublicDirectory(
//     ExtStorage.DIRECTORY_DOWNLOADS);
// print("dir $dir");
// String file = "$dir";

// File f = File(file + "/filename.csv");

// f.writeAsString(csv);
    // updateState();
  }

  updateState() {
    notifyListeners();
  }
}
