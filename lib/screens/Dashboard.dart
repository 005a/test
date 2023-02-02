import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:test/logic/taskManager.dart';
import 'package:test/models/CardModel.dart';
import 'package:test/models/TaskStatusModel.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final taskP = Provider.of<TaskProvider>(context);

    return Scaffold(
        body: Center(
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: TaskStatus.values.map((element) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2.5,
              child: Column(
                children: [
                  Expanded(flex: 1, child: Text(element.name)),
                  Expanded(
                      flex: 11,
                      child: DragTarget(
                        builder: (context, candidateItems, rejectedItems) {
                          return ListView(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(5),
                            children: taskP.taskList.map((e) {
                              if (e.status.name == element.name) {
                                Widget card = TaskCard(title: e.title);
                                return LongPressDraggable(
                                  data: e,
                                  feedback: card,
                                  child: card,
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }).toList(),
                          );
                        },
                        onAccept: (CardModel item) {
                          taskP.editCard(item
                            ..status = TaskStatus.values
                                .firstWhere((ts) => ts.name == element.name));
                        },
                      ))
                ],
              ),
            );
          }).toList()),
    ));
  }
}

class TaskCard extends StatelessWidget {
  String title;
  TaskCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: GestureDetector(
        onTap: () {
          showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text(title),
                    content: Text(title),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('defaultActionText'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ));
        },
        child: Card(
          color: Colors.red,
          child: Text(title),
        ),
      ),
    );
  }
}
