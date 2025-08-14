import 'package:flutter/material.dart';
import 'package:todolist/screen/task_search_result_screen.dart';
import 'package:todolist/services/taskServices.dart';

class TaskSearchScreen extends StatefulWidget {
  const TaskSearchScreen({super.key});
  @override
  State<TaskSearchScreen> createState() => _TaskSearchState();
}

class _TaskSearchState extends State<TaskSearchScreen> {
  final _searchController = TextEditingController();
  Future<void> handleSearch() async {
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Key word is required!"),
            backgroundColor: Colors.red),
      );
      return;
    }
    try {
      await TaskService.searchTasksKeyword(keyword);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Search Success!"), backgroundColor: Colors.red),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => TaskSearchResultScreen()));
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
          children: [],
        ),
      ),
    );
  }
}
