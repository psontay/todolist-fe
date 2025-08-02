import 'package:flutter/material.dart';

Container loginContainer({
  required String boxName,
  required Alignment direction,
  required TextEditingController usernameController,
  required TextEditingController passwordController,
  required VoidCallback onLoginPressed,
  bool boxRadius = false,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(boxRadius ? 100 : 10),
    ),
    width: 300,
    height: 300,
    alignment: direction,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          boxName,
          style: const TextStyle(fontSize: 24, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: usernameController,
          decoration: const InputDecoration(
            hintText: 'Username',
            fillColor: Colors.grey,
            filled: true,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Password',
            fillColor: Colors.grey,
            filled: true,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onLoginPressed,
          child: const Text("Login"),
        ),
      ],
    ),
  );
}
