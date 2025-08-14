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
  bool _loading = true;
  String? _error;
  UserResponse? _user;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAndRedirect());
  }

  Future<void> _loadAndRedirect() async {
    setState(() => _loading = true);
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
          MaterialPageRoute(builder: (_) => UserProfileScreen(user: user)),
        );
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load profile: $_error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadAndRedirect,
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
