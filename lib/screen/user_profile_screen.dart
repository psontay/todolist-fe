import 'package:flutter/material.dart';

import '../entities/TaskResponse.dart';
import '../entities/UserResponse.dart';

class UserProfileScreen extends StatelessWidget {
  final UserResponse user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Your Profile'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info
            Text(
              user.username,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              user.email,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: user.roles
                  .map((role) => Chip(
                        label: Text(
                          role,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.blueGrey,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tasks',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Task list
            Expanded(
              child: user.tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'No tasks assigned.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: user.tasks.length,
                      itemBuilder: (context, index) {
                        TaskResponse task =
                            user.tasks.elementAt(index); // convert Set to index
                        return Card(
                          color: Colors.grey[900],
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(
                              task.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Deadline: ${task.deadline.toLocal()}',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
