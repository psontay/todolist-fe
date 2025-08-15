import 'package:flutter/material.dart';
import 'package:todolist/widgets/search_list.dart';

class SearchListScreen extends StatelessWidget {
  final String keyword;
  const SearchListScreen({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Search Results: \"$keyword\"",
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SearchListWidget(keyword: keyword),
    );
  }
}
