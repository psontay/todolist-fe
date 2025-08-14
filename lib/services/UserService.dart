import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todolist/constants.dart';
import 'package:todolist/entities/TaskResponse.dart';
import 'package:todolist/entities/UserResponse.dart';

import 'TokenStorage.dart';

class UserService {
  static const _baseUrl = BASE_URL;

  static Future<UserResponse> profile() async {
    final url = Uri.parse('$_baseUrl/users/me');
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found. Please login again.");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    }).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return UserResponse.fromJson(data);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to fetch profile');
    }
  }

  static Future<UserResponse> getUserByEmail(String email) async {
    final encodedEmail = Uri.encodeComponent(email);
    final url = Uri.parse('$_baseUrl/users/getUserByEmail/$encodedEmail');
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found. Please login again.");
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return UserResponse.fromJson(data);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'User not found');
    }
  }

  static Future<void> updateUser({
    required String id,
    required String name,
    required String email,
    required String password,
    required Set<String> roles,
    required List<TaskResponse> tasks,
  }) async {
    final url = Uri.parse('$_baseUrl/users/updateUser/$id');
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found. Please login again.");

    final body = {
      'name': name,
      'email': email,
      'password': password,
      'roles': roles.toList(),
      'tasks': tasks
          .map((t) => {
                'id': t.id,
                'title': t.title,
                'status': t.status,
              })
          .toList(),
    };

    final response = await http
        .put(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to update user');
    }
  }
}
