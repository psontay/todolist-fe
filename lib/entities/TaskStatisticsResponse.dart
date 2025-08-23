class TaskStatisticsResponse {
  final int total, pending, completed;
  TaskStatisticsResponse(
      {required this.total, required this.completed, required this.pending});
  factory TaskStatisticsResponse.fromJson(Map<String, dynamic> json) {
    return TaskStatisticsResponse(
      total: json['total'],
      completed: json['completed'],
      pending: json['pending'],
    );
  }
}
