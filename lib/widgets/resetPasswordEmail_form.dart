import 'package:flutter/material.dart';

class ResetPasswordEmailForm extends StatelessWidget {
  final TextEditingController emailController;
  final VoidCallback onSendPressed;
  const ResetPasswordEmailForm({
    super.key,
    required this.emailController,
    required this.onSendPressed,
  });

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
            'Reset Password By Email',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 24),
          _buildField(emailController, 'Email'),
          ElevatedButton(
            onPressed: onSendPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.green,
            ),
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String hintText,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
