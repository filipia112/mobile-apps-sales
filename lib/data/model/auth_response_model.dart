import 'package:equatable/equatable.dart';

class AuthResponseModel extends Equatable {
  final String token;
  final String id;

  const AuthResponseModel({
    required this.token,
    required this.id,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'id': id,
  };

  @override
  List<Object?> get props => [token, id];
}

