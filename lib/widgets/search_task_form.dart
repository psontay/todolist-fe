import 'package:flutter/material.dart';

class SearchTaskForm extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback onSearchPressed;
  const SearchTaskForm(
      {super.key,
      required this.searchController,
      required this.onSearchPressed});
  @override
  State<SearchTaskForm> createState() => _SearchTaskState();
}

class _SearchTaskState extends State<SearchTaskForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Search Task',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 24),
          _buildField(widget.searchController, 'Keyword'),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: widget.onSearchPressed, child: const Text('Create')),
        ],
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
