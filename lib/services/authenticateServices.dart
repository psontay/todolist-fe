import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static Future<void> login(String username, String password) async {
    final url = Uri.parse('http://192.168.1.7:8080/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('✅ Đăng nhập thành công!');
      print('Response: ${response.body}');
    } else {
      print('❌ Đăng nhập thất bại!');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  }
}
