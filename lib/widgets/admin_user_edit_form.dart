import 'package:flutter/material.dart';
import 'package:todolist/entities/TaskResponse.dart';

class EditableTask {
  String? id;
  String title;
  String status;

  EditableTask({this.id, required this.title, required this.status});

  TaskResponse toTaskResponse() {
    return TaskResponse(
      id: id!,
      title: title,
      status: status,
      createdAt: DateTime.now(),
      deadline: DateTime.now(),
    );
  }
}

class AdminUserEditForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Set<String> initialRoles;
  final List<TaskResponse> initialTasks;
  final void Function(Set<String> updatedRoles, List<TaskResponse> updatedTasks,
      String password) onSave;
  final VoidCallback onCancel;

  const AdminUserEditForm({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.initialRoles,
    required this.initialTasks,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<AdminUserEditForm> createState() => _AdminUserEditFormState();
}

class _AdminUserEditFormState extends State<AdminUserEditForm> {
  late Set<String> _selectedRoles;
  late List<EditableTask> _editableTasks;
  late List<TextEditingController> _taskControllers;

  @override
  void initState() {
    super.initState();
    _selectedRoles = {...widget.initialRoles};

    _editableTasks = widget.initialTasks
        .map((t) => EditableTask(id: t.id, title: t.title, status: t.status))
        .toList();
    _taskControllers = _editableTasks
        .map((et) => TextEditingController(text: et.title))
        .toList();
  }

  @override
  void dispose() {
    for (var ctrl in _taskControllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white10,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.nameController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: widget.emailController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Email'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: widget.passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Password'),
          ),
          const SizedBox(height: 20),
          const Text('Roles:',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: ['ADMIN', 'USER'].map((role) {
              return FilterChip(
                label: Text(role, style: const TextStyle(color: Colors.white)),
                selected: _selectedRoles.contains(role),
                onSelected: (selected) {
                  setState(() {
                    if (selected)
                      _selectedRoles.add(role);
                    else
                      _selectedRoles.remove(role);
                  });
                },
                selectedColor: Colors.grey[900],
                backgroundColor: Colors.grey[900],
                checkmarkColor: Colors.greenAccent,
                showCheckmark: true,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text('Tasks:',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 6),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _editableTasks.length,
            itemBuilder: (context, idx) {
              final task = _editableTasks[idx];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _taskControllers[idx],
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputDecoration('Task ${idx + 1}'),
                    onChanged: (value) => task.title = value,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: task.status,
                    dropdownColor: Colors.black,
                    decoration: _inputDecoration('Status'),
                    items: ['PENDING', 'IN_PROGRESS', 'COMPLETED']
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s,
                                  style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => task.status = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey[700]),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: widget.onCancel,
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                onPressed: () {
                  final updatedTasks = _editableTasks
                      .map((et) => TaskResponse(
                            id: et.id!,
                            title: et.title,
                            status: et.status,
                            createdAt: DateTime.now(),
                            deadline: DateTime.now(),
                          ))
                      .toList();
                  widget.onSave(_selectedRoles, updatedTasks,
                      widget.passwordController.text.trim());
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
