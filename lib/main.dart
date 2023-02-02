import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/logic/taskManager.dart';
import 'package:test/screens/Dashboard.dart';

void main() {
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(child: Dashboard()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<TaskProvider>(context, listen: false).addCard();
        },
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
    );
  }
}
