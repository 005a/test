import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/logic/taskManager.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskP = Provider.of<TaskProvider>(context);

    return Drawer(
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
    ));
  }
}
