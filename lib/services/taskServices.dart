import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todolist/constants.dart';
import 'package:todolist/entities/TaskResponse.dart';
import 'package:todolist/entities/TaskSearchResponse.dart';
import 'package:todolist/entities/TaskStatus.dart';

import '../entities/TaskStatisticsResponse.dart';
import 'TokenStorage.dart';

class TaskService {
  static const _baseUrl = BASE_URL;
  static final _taskCrudUrl = Uri.parse('$_baseUrl/tasks');
  static Future<void> createTask(String title, DateTime deadline) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found. Please login again.");
    final response = await http.post(
      _taskCrudUrl,
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
    if (response.statusCode != 200 && response.statusCode != 201) {
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

  static Future<List<TaskResponse>> getAllTasks() async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found . Please login again.");
    final response = await http.get(
      _taskCrudUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return List<TaskResponse>.from(
          data.map((json) => TaskResponse.fromJson(json)));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to fetch tasks');
    }
  }

  static Future<void> updateTask(
      String id, String title, String status, DateTime deadline) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found. Please login again.");

    final url = Uri.parse('$_taskCrudUrl/$id');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'status': status,
        'deadline': deadline.toIso8601String(),
      }),
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Update failed');
    }
  }

  static Future<void> deleteTask(String id) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found . Please try again");
    final url = Uri.parse('$_taskCrudUrl/$id');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Delete failed');
    }
  }

  static Future<List<TaskResponse>> searchTasksKeyword(String keyword) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found . Please try again");
    final url = Uri.parse('$_taskCrudUrl/search?keyword=$keyword');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final taskSearch = TaskSearchResponse.fromJson(data['data']);
      return taskSearch.results;
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Search Failed');
    }
  }

  static Future<void> getTasksByStatus(TaskStatus taskStatus) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found . Please try again");
    final url = Uri.parse('$_taskCrudUrl/&$taskStatus');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Fetched tasks by status failed');
    }
  }

  static Future<List<TaskResponse>> getTasksSortedByStatus() async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found . Please try again");
    final url = Uri.parse('$_taskCrudUrl/sort/status');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> taskList = jsonData['data'];
      return taskList.map((e) => TaskResponse.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load tasks sorted by status");
    }
  }

  static Future<List<TaskResponse>> getTasksSortedByDeadline() async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found . Please try again");
    final url = Uri.parse('$_taskCrudUrl/sort/deadline');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> taskList = jsonData['data'];
      return taskList.map((e) => TaskResponse.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load tasks sorted by deadline");
    }
  }

  static Future<TaskStatisticsResponse> getTaskStatistics() async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token not found . Please try again");
    final url = Uri.parse('$_taskCrudUrl/statistics');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return TaskStatisticsResponse.fromJson(data);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to fetch task statistics');
    }
  }
}
