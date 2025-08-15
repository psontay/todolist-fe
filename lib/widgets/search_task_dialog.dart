import 'package:flutter/material.dart';

import '../screen/search_list_screen.dart';

class SearchTaskDialog extends StatefulWidget {
  const SearchTaskDialog({super.key});

  @override
  State<SearchTaskDialog> createState() => _SearchTaskDialogState();
}

class _SearchTaskDialogState extends State<SearchTaskDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text("Search Tasks", style: TextStyle(color: Colors.white)),
      content: TextField(
        controller: _controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: "Enter keyword...",
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            final keyword = _controller.text.trim();
            if (keyword.isNotEmpty) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchListScreen(keyword: keyword),
                ),
              );
            }
          },
          child: const Text("Search"),
        ),
      ],
    );
  }
}
