import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:test/logic/taskManager.dart';
import 'package:test/models/TaskModel.dart';

@immutable
class TaskCard extends StatelessWidget {
  TaskModel card;
  TaskCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskP = Provider.of<TaskProvider>(context);

    return SizedBox(
      height: 100,
      child: Card(
        color: Theme.of(context).cardColor,
        child: Center(
            child: Column(
          children: [
            Text(card.title),
            Text(
                '${DateTime.fromMillisecondsSinceEpoch(card.timeSpent).difference(DateTime.fromMillisecondsSinceEpoch(0))}'),
          ],
        )),
      ),
    );
  }
}

editMenu(BuildContext context, TaskModel selectedTask, action) {
  final TextEditingController textEditingController =
      TextEditingController(text: selectedTask.title);

  showModalBottomSheet(
      context: context,
      builder: (context) => Material(
            child: Column(
              children: [
                Card(
                    child: Column(
                  children: [
                    const Text('Change task name:'),
                    TextField(
                      controller: textEditingController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                        TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              selectedTask.title = textEditingController.text;
                              action(selectedTask);
                              Navigator.of(context).pop(true);
                            }),
                      ],
                    ),
                  ],
                )),
                Card(
                    child: Column(
                  children: [
                    Text(selectedTask.startedAt.toString()),
                    Text(selectedTask.timeSpent.toString()),
                  ],
                ))
              ],
            ),
          ));
}
