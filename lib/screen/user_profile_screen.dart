import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Your Profile'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'This is the user profile screen.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
