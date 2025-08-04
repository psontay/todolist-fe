import 'package:flutter/material.dart';
import 'package:todolist/entities/UserResponse.dart';
import 'package:todolist/screen/admin_user_screen.dart';
import 'package:todolist/screen/user_profile_screen.dart';
import 'package:todolist/services/UserService.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _redirectBasedOnRole();
  }

  Future<void> _redirectBasedOnRole() async {
    try {
      UserResponse user = await UserService.profile();

      if (user.roles.contains('ADMIN')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminUserScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const UserProfileScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile: $e')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
