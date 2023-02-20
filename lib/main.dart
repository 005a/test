import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/logic/init.dart';
import 'package:test/logic/taskManager.dart';
import 'package:test/screens/Dashboard.dart';
import 'package:test/screens/components/DefaultDrawer.dart';

void main() async {
  await initHive();

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

  static void main() {}
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TaskProvider taskP = Provider.of<TaskProvider>(context, listen: false);
      taskP.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskP, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: const Center(child: Dashboard()),
          drawer: const DefaultDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              taskP.addCard();
            },
            tooltip: 'Create',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
