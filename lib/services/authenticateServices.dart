import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todolist/services/TokenStorage.dart';

class AuthService {
  static const _baseUrl = 'http://192.168.1.2:8080';

  static Future<void> login(String name, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': name, 'password': password}),
    );

    if (response.statusCode == 200) {
      print('✅ Login success!');
      print('Response: ${response.body}');
      final responseData = jsonDecode(response.body);
      final token = responseData['data']['token'];
      await TokenStorage.saveToken(token);
      print("Login success, token saved: ${token.toString()}");
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Login failed');
    }
  }

  static Future<void> signup(String name, String password, String email) async {
    final url = Uri.parse('$_baseUrl/users/create');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'password': password, 'email': email}),
    );

    if (response.statusCode == 200) {
      print('Signup success!');
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Signup failed');
    }
  }

  static Future<String> resetPasswordEmail(String email) async {
    final url = Uri.parse('$_baseUrl/auth/reset-password');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    print('🔵 Response Status Code: ${response.statusCode}');
    print('🔵 Response Body: "${response.body}"');

    try {
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return body['data']?['message'] ?? 'Email sent';
      } else {
        // Lỗi có JSON
        throw Exception(body['message'] ?? 'Unknown error');
      }
    } catch (e) {
      print('🔴 JSON decode error: $e');
      throw Exception('Unexpected error response from server');
    }
  }
}
