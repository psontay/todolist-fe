import 'package:flutter/material.dart';

class CreateTaskForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController deadlineController;
  final VoidCallback onCreatePressed;
  const CreateTaskForm(
      {super.key,
      required this.deadlineController,
      required this.titleController,
      required this.onCreatePressed});
  @override
  State<CreateTaskForm> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTaskForm> {
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
            'Create Task',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 24),
          _buildField(widget.titleController, 'Title'),
          const SizedBox(height: 24),
          TextField(
            controller: widget.deadlineController,
            readOnly: true,
            decoration: const InputDecoration(
              hintText: 'Deadline',
              filled: true,
              fillColor: Colors.grey,
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
            ),
            style: const TextStyle(color: Colors.white),
            onTap: () async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100));
              if (date == null) return;
              final time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              if (time == null) return;
              final selectedDateTime = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: widget.onCreatePressed,
            child: const Text('Create'),
          ),
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
