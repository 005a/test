import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/logic/taskManager.dart';

Widget wrapWithMaterial(child) => MaterialApp(
      home: ListenableProvider<TaskProvider>(
        create: (_) => MockTaskProvider(),
        child: Scaffold(
          body: child,
        ),
      ),
    );

class MockTaskProvider extends Mock implements TaskProvider {}
