import 'dart:convert';

import 'package:http/http.dart' as http;

import 'TokenStorage.dart';

class TaskService {
  static const _baseUrl = 'http://192.168.1.2:8080';
  static Future<void> createTask(String title, DateTime deadline) async {
    final url = Uri.parse('$_baseUrl/tasks/create');
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found. Please login again.");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body:
          jsonEncode({'title': title, 'deadline': deadline.toIso8601String()}),
    );
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');
    final body = response.body.trim();
    if (response.statusCode != 200) {
      if (body.isEmpty) {
        throw Exception('Create Failed: empty response');
      }

      try {
        final error = jsonDecode(body);
        throw Exception(error['message'] ?? 'Create Failed');
      } catch (e) {
        throw Exception('Create Failed: ${response.reasonPhrase}');
      }
    }
  }
}
