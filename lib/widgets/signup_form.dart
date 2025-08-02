import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final VoidCallback onSubmit;

  const SignupForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.emailController,
    required this.onSubmit,
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
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "SIGN UP",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Name is required" : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Password is required";
                if (value.length < 6) return "Password at least 6 characters";
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Email is required";
                if (!value.endsWith("@gmail.com") &&
                    !value.endsWith(".edu.vn")) {
                  return "Email must ending with @gmail.com or .edu.vn";
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }
}
