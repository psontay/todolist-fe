import 'package:flutter/material.dart';

import '../widgets/TaskList.dart';

class TaskSearchResultScreen extends StatefulWidget {
  TaskSearchResultScreen({super.key});
  @override
  State<TaskSearchResultScreen> createState() => _TaskSearchState();
}

class _TaskSearchState extends State<TaskSearchResultScreen> {
  final GlobalKey<TaskListWidgetState> _taskListKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TaskListWidget(key: _taskListKey),
    );
  }
}
