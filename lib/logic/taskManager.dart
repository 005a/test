import 'package:test/models/CardModel.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  List<CardModel> _taskList = [];
  List<CardModel> get taskList => _taskList;

  void addCard() {
    _taskList.add(CardModel(id: _taskList.isEmpty ? 1 : 1 + _taskList.last.id));
    notifyListeners();
  }

  void removeCard(CardModel card) {
    _taskList = ([..._taskList..removeWhere((element) => element == card)]);
    notifyListeners();
  }

  void editCard(CardModel card) {
    _taskList =
        ([..._taskList..removeWhere((element) => element.id == card.id), card]);
    notifyListeners();
  }

  // void startTimer() {

  // }

}
