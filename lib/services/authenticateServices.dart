import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static Future<void> login(String name, String password) async {
    final url = Uri.parse('http://192.168.1.7:8080/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': name, 'password': password}),
      );

      if (response.statusCode == 200) {
        print('Login success!');
        print('Response: ${response.body}');
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signup(String name, String password, String email) async {
    final url = Uri.parse('http://192.168.1.7:8080/users/create');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'password': password,
        'email': email,
      }),
    );
    if (response.statusCode == 200) {
      print('✅ Signup success!');
      print('Response: ${response.body}');
    } else {
      print('❌ Signup failed!');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  }
}
