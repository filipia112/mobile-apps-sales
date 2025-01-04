import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String username;
  final String passUser;

  const AuthModel({
    required this.username,
    required this.passUser,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'passUser': passUser,
  };

  @override
  List<Object?> get props => [username, passUser];
}