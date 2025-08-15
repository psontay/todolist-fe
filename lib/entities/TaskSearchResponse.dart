import 'TaskResponse.dart';

class TaskSearchResponse {
  final List<TaskResponse> results;

  TaskSearchResponse({required this.results});

  factory TaskSearchResponse.fromJson(Map<String, dynamic> json) {
    return TaskSearchResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => TaskResponse.fromJson(e))
          .toList(),
    );
  }
}
