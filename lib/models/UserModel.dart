import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'UserModel.g.dart';

@HiveType(typeId: 3)
class UserModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int? timeSpent;
  UserModel({required this.id, this.name = '', this.timeSpent, Key? key});
}
