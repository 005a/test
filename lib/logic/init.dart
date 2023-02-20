import 'package:hive_flutter/hive_flutter.dart';
import 'package:test/models/TaskModel.dart';
import 'package:test/models/UserModel.dart';

initHive() async {
  await Hive.initFlutter();
  //register adapters before openbox
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  Hive.registerAdapter<TaskStatus>(TaskStatusAdapter());
  Hive.registerAdapter<UserModel>(UserModelAdapter());

  await Hive.openBox<TaskModel>('tasks');
}
