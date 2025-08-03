import 'package:flutter/material.dart';
import 'package:todolist/widgets/TaskList.dart';
import 'package:todolist/widgets/create_task_dialog.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<TaskListWidgetState> _taskListKey = GlobalKey();

  void _handleLogout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _showCreateDialog(BuildContext context) async {
    final created = await showDialog<bool>(
      context: context,
      builder: (_) => const CreateTaskDialog(),
    );

    if (created == true) {
      _taskListKey.currentState?.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('TODOLIST'),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        leading: IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Create Task',
          onPressed: () => _showCreateDialog(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
          )
        ],
      ),
      body: TaskListWidget(key: _taskListKey),
    );
  }
}
