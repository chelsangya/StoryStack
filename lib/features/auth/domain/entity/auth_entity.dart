import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String? email;
  final String? phone;
  final String? password;
  @override
  List<Object?> get props => [userId, email, phone, password];

  const AuthEntity({
    this.userId,
    this.email,
    this.phone,
    this.password,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) => AuthEntity(
        userId: json['_id'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        '_id': userId,
        'email': email,
        'phone': phone,
        'password': password,
      };

  @override
  String toString() {
    return 'AuthEntity { userId: $userId, email: $email, phone: $phone, password: $password}';
  }
}
