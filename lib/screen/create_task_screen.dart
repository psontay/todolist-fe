import 'package:flutter/material.dart';
import 'package:todolist/screen/HomeScreen.dart';
import 'package:todolist/services/taskServices.dart';
import 'package:todolist/widgets/create_task_form.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _titleController = TextEditingController();
  final _deadlineController = TextEditingController();
  Future<void> handleCreateTask() async {
    final title = _titleController.text.trim();
    final deadlineStr = _deadlineController.text.trim();
    if (title.isEmpty || deadlineStr.isEmpty) {
      final msg =
          title.isEmpty ? "Username is required" : "Password is required";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: Colors.red),
      );
      return;
    }
    try {
      final deadline = DateTime.parse(deadlineStr);
      await TaskService.createTask(title, deadline);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Create Success"), backgroundColor: Colors.green),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CreateTaskForm(
                deadlineController: _deadlineController,
                titleController: _titleController,
                onCreatePressed: handleCreateTask),
            const SizedBox(height: 16),
            TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomeScreen())),
                child: const Text(
                  "Create Task",
                  style: TextStyle(color: Colors.green),
                ))
          ],
        ),
      ),
    );
  }
}
