import 'TaskResponse.dart';

class UserResponse {
  String id;
  String username;
  String email;
  Set<String> roles;
  Set<TaskResponse> tasks;

  UserResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
    required this.tasks,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toSet(),
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TaskResponse.fromJson(e as Map<String, dynamic>))
          .toSet(),
    );
  }
  @override
  String toString() {
    return 'UserResponse(id: $id, username: $username, email: $email, roles: $roles, tasks count: ${tasks.length})';
  }
}
