import 'package:flutter/material.dart';
import 'package:todolist/screen/login_screen.dart';
import 'package:todolist/widgets/resetPasswordEmail_form.dart';

import '../services/authenticateServices.dart';

class ResetPasswordEmailScreen extends StatefulWidget {
  const ResetPasswordEmailScreen({super.key});
  @override
  State<ResetPasswordEmailScreen> createState() =>
      _ResetPasswordEmailScreenState();
}

class _ResetPasswordEmailScreenState extends State<ResetPasswordEmailScreen> {
  final _emailController = TextEditingController();
  Future<void> _handleResetPasswordEmail() async {
    final email = _emailController.text.trim();

    if (email.isEmpty ||
        (!email.endsWith("@gmail.com") && !email.endsWith(".edu.vn"))) {
      _showMessage("Valid email required (gmail.com or .edu.vn)");
      return;
    }

    try {
      final message = await AuthService.resetPasswordEmail(email);
      _showMessage(message);
    } catch (e) {
      _showMessage("Sent email failed: ${e.toString()}");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.black),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ResetPasswordEmailForm(
                emailController: _emailController,
                onSendPressed: _handleResetPasswordEmail,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
