import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/logic/taskManager.dart';
import 'package:test/screens/Dashboard.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

@immutable
class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final taskP = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(child: Dashboard()),
      drawer: Drawer(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () {
                  taskP.exportCSV();
                  Navigator.of(context).pop(true);
                },
                child: const Text('Export CSV'))
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskP.addCard();
        },
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
    );
  }
}
