import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/entities/TaskResponse.dart';
import 'package:todolist/services/taskServices.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => TaskListWidgetState();
}

class TaskListWidgetState extends State<TaskListWidget> {
  late Future<List<TaskResponse>> _futureTasks;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    setState(() {
      _futureTasks = TaskService.getAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TaskResponse>>(
      future: _futureTasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('⚠️ Error: \'${snapshot.error}',
                style: const TextStyle(color: Colors.red)),
          );
        }

        final tasks = snapshot.data ?? [];

        if (tasks.isEmpty) {
          return const Center(
            child:
                Text("📝 No tasks yet", style: TextStyle(color: Colors.white)),
          );
        }

        return ListView.separated(
          itemCount: tasks.length,
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Created At: ${DateFormat('yyyy-MM-dd HH:mm').format(task.createdAt)}",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        Text(
                          "Deadline: ${DateFormat('yyyy-MM-dd HH:mm').format(task.deadline)}",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        Text("Status: \'${task.status}'",
                            style: TextStyle(color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () => _showEditDialog(context, task),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showDeleteDialog(context, task.id),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, TaskResponse task) {
    final titleController = TextEditingController(text: task.title);
    DateTime? selectedDeadline =
        DateTime.tryParse(task.deadline.toIso8601String());
    final deadlineController = TextEditingController(
      text: selectedDeadline != null
          ? DateFormat('yyyy-MM-dd HH:mm').format(selectedDeadline)
          : '',
    );
    String status = task.status;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Edit Task', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: status,
                  dropdownColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: 'Status',
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                  items: ['PENDING', 'IN_PROGRESS', 'COMPLETED']
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child:
                                Text(s, style: TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) status = value;
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: deadlineController,
                  readOnly: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Deadline',
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.access_time, color: Colors.white),
                  ),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDeadline ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            selectedDeadline ?? DateTime.now()),
                      );
                      if (pickedTime != null) {
                        selectedDeadline = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        deadlineController.text = DateFormat('yyyy-MM-dd HH:mm')
                            .format(selectedDeadline!);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (selectedDeadline == null) {
                    throw Exception("Deadline is required");
                  }

                  await TaskService.updateTask(
                    task.id,
                    titleController.text,
                    status,
                    selectedDeadline!,
                  );
                  Navigator.pop(context);
                  _loadTasks();
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Delete Task', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to delete this task?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.green)),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                Navigator.pop(context);
                await TaskService.deleteTask(taskId);
                _loadTasks();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Task deleted")),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            child: const Text('Delete'),
          )
        ],
      ),
    );
  }

  void refresh() {
    _loadTasks();
  }
}
