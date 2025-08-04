import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const ProfileForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.emailController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  bool _obscurePassword = true;

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
    return Column(
      children: [
        TextField(
          controller: widget.usernameController,
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
          obscureText: _obscurePassword,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Password').copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: widget.onCancel,
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: widget.onSave,
              child: const Text('Save'),
            ),
          ],
        )
      ],
    );
  }
}
