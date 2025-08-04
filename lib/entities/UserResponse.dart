import 'TaskResponse.dart';

class UserResponse {
  String id;
  String name;
  String email;
  Set<String> roles;
  Set<TaskResponse> tasks;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.tasks,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toSet(),
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TaskResponse.fromJson(e as Map<String, dynamic>))
          .toSet(),
    );
  }
  @override
  String toString() {
    return 'UserResponse(id: $id, name: $name, email: $email, roles: $roles, tasks count: ${tasks.length})';
  }
}
