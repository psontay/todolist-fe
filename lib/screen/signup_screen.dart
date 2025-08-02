import 'package:flutter/material.dart';
import 'package:todolist/screen/login_screen.dart';
import 'package:todolist/services/authenticateServices.dart';
import 'package:todolist/widgets/signup_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  void handleSignup() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final email = emailController.text.trim();
    String? error;
    if (username.isEmpty) {
      error = "Name is required";
    } else if (password.isEmpty || password.length < 6) {
      error = "Password is required or at least 6 chars";
    } else if (email.isEmpty) {
      error = "Email is required";
    } else if (!email.endsWith("@gmail.com") && !email.endsWith(".edu.vn")) {
      error = "Email end with @gmail.com or .edu.vn";
    }

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.black),
      );
      return;
    }
    try {
      await AuthService.signup(username, password, email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Signup success ! Please login .."),
            backgroundColor: Colors.black),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.black),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SignupForm(
              usernameController: usernameController,
              passwordController: passwordController,
              emailController: emailController,
              onSubmit: handleSignup,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text(
                "LOGIN",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
