import 'package:flutter/material.dart';
import 'package:todolist/services/taskServices.dart';

class SearchTaskDialog extends StatefulWidget {
  const SearchTaskDialog({super.key});
  @override
  State<SearchTaskDialog> createState() => _SearchTaskDialogState();
}

class _SearchTaskDialogState extends State<SearchTaskDialog> {
  final _searchController = TextEditingController();
  Future<void> _handleSubmit() async {
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keyword is required!')),
      );
      return;
    }
    try {
      await TaskService.searchTasksKeyword(keyword);
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Search Success!')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error : $e')));
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
            const Text('Search Task',
                style: TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 12),
            TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Keyword',
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _handleSubmit, child: const Text('Search')),
          ],
        ),
      ),
    );
  }
}
