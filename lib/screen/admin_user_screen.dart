import 'package:flutter/material.dart';
import 'package:todolist/entities/TaskResponse.dart';
import 'package:todolist/entities/UserResponse.dart';
import 'package:todolist/screen/HomeScreen.dart';
import 'package:todolist/services/UserService.dart';
import 'package:todolist/widgets/admin_user_edit_form.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserResponse? _selectedUser;
  bool _loading = false;

  Future<void> _searchUser() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    setState(() => _loading = true);
    try {
      final user = await UserService.getUserByEmail(query);
      setState(() {
        _selectedUser = user;
        _nameController.text = user.username;
        _emailController.text = user.email;
        _passwordController.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ User not found")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _handleSave(
      Set<String> roles, List<TaskResponse> tasks, String password) async {
    if (_selectedUser == null) return;
    setState(() => _loading = true);
    try {
      await UserService.updateUser(
        id: _selectedUser!.id,
        name: _nameController.text,
        email: _emailController.text,
        password: password,
        roles: roles,
        tasks: tasks,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ User updated")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  void _handleBack(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin User Management'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _handleBack(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Enter email',
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _loading ? null : _searchUser,
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_selectedUser != null)
              Expanded(
                child: AdminUserEditForm(
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  initialRoles: _selectedUser!.roles,
                  initialTasks: _selectedUser!.tasks.toList(),
                  onSave: _handleSave,
                  onCancel: () => setState(() => _selectedUser = null),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
