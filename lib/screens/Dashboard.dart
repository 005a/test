import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:test/logic/taskManager.dart';
import 'package:test/models/TaskModel.dart';
import 'package:test/screens/components/TaskCard.dart';

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
                            children: taskP.taskList.map((selectedTask) {
                              if (selectedTask.status.name == element.name) {
                                Widget card = TaskCard(card: selectedTask);

                                return PullDownButton(
                                  itemBuilder: (context) => [
                                    PullDownMenuItem(
                                        title: 'Edit task',
                                        onTap: () => editMenu(context,
                                            selectedTask, taskP.editCard)),
                                    const PullDownMenuDivider(),
                                    PullDownMenuItem(
                                      title: 'Delete',
                                      onTap: () =>
                                          taskP.removeCard(selectedTask),
                                    ),
                                  ],
                                  position: PullDownMenuPosition.under,
                                  buttonBuilder: (context, showMenu) =>
                                      CupertinoButton(
                                    onPressed: showMenu,
                                    padding: EdgeInsets.zero,
                                    child: Draggable(
                                      data: selectedTask,
                                      feedback: card,
                                      child: card,
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }).toList(),
                          );
                        },
                        onAccept: (TaskModel item) {
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
