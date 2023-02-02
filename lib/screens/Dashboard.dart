import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.1)),
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
                                Widget card = TaskCard(card: e);
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
  CardModel card;
  final TextEditingController _textEditingController = TextEditingController();
  TaskCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskP = Provider.of<TaskProvider>(context);

    return SizedBox(
      height: 100,
      child: GestureDetector(
        onTap: () {
          showCupertinoDialog(
              context: context,
              builder: (context) => Material(
                    child: CupertinoAlertDialog(
                      title: Text(card.title),
                      content: TextField(
                        controller: _textEditingController,
                      ),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('cancel'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                        CupertinoDialogAction(
                          child: Text('ok'),
                          onPressed: () {
                            card.title = _textEditingController.text;
                            taskP.editCard(card);
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    ),
                  ));
        },
        child: Card(
          color: Theme.of(context).cardColor,
          child: Text(card.title),
        ),
      ),
    );
  }
}
