import 'package:flutter/material.dart';

import '../services/authenticateServices.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void handleLogin() {
    final username = usernameController.text;
    final password = passwordController.text;
    AuthService.login(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loginContainer(
          boxName: "LOGIN",
          direction: Alignment.topCenter,
          usernameController: usernameController,
          passwordController: passwordController,
          onLoginPressed: handleLogin,
        ),
      ),
    );
  }
}
