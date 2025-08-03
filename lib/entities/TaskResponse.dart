class TaskResponse {
  final String id;
  final String title;
  final String status;
  final DateTime createdAt;
  final DateTime deadline;

  TaskResponse({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.deadline,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      deadline: DateTime.parse(json['deadline']),
    );
  }
}
