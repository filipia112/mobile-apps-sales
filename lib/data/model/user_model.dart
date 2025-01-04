class UserModel {
  final String nmUser;
  final String username;
  final String roleUser;
  final DateTime updatedAt;

  UserModel({
    required this.nmUser,
    required this.username,
    required this.roleUser,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nmUser: json['nmUser'] ?? '',
      username: json['username'] ?? '',
      roleUser: json['roleUser'] ?? '',
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nmUser': nmUser,
      'username': username,
      'roleUser': roleUser,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
