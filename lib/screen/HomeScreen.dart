import 'package:flutter/material.dart';
import 'package:todolist/widgets/TaskList.dart';
import 'package:todolist/widgets/create_task_dialog.dart';

import '../widgets/search_task_dialog.dart';
import 'ProfileScreen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<TaskListWidgetState> _taskListKey = GlobalKey();
  void _handleMenu(BuildContext context) {}
  void _handleLogout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _profileManagement(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ProfileScreen()),
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

  void _showSearchTaskDialog(BuildContext context) async {
    final created = await showDialog<bool>(
      context: context,
      builder: (_) => const SearchTaskDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              child: Text('Menu', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text(
                '📊 Statistics task',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                print("Statistics task");
              },
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('📅 Sort by deadline',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                print("Sort by deadline");
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_alt),
              title: const Text('🏷️ Sort by status',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                print("Sort by status");
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('ToDoList'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => _showSearchTaskDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create Task',
            onPressed: () => _showCreateDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profile',
            onPressed: () => _profileManagement(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: TaskListWidget(key: _taskListKey),
    );
  }
}
