import 'package:flutter/material.dart';

import '../services/taskServices.dart';

class CreateTaskDialog extends StatefulWidget {
  const CreateTaskDialog({super.key});

  @override
  State<CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final _titleController = TextEditingController();
  final _deadlineController = TextEditingController();

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final selected = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    _deadlineController.text = selected.toIso8601String();
  }

  Future<void> _handleSubmit() async {
    final title = _titleController.text.trim();
    final deadlineStr = _deadlineController.text.trim();

    if (title.isEmpty || deadlineStr.isEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title & deadline are required')),
      );
      return;
    }

    try {
      final deadline = DateTime.parse(deadlineStr);
      await TaskService.createTask(title, deadline);
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task created')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      contentPadding: const EdgeInsets.all(16),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Create Task',
                style: TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _deadlineController,
              readOnly: true,
              onTap: _selectDateTime,
              decoration: const InputDecoration(
                hintText: 'Select Deadline',
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
