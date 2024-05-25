import 'package:json_annotation/json_annotation.dart';
import 'package:story_stack/features/auth/domain/entity/auth_entity.dart';

@JsonSerializable()
class AuthAPIModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String? email;
  final String? phone;
  final String? password;

  AuthAPIModel({
    this.userId,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory AuthAPIModel.fromJson(Map<String, dynamic> json) {
    return AuthAPIModel(
      userId: json['_id'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password
    };
  }

  // From entity to model
  factory AuthAPIModel.fromEntity(AuthEntity entity) {
    return AuthAPIModel(

        email: entity.email,

        phone: entity.phone,
        password: entity.password);
  }

  // From model to entity
  static AuthEntity toEntity(AuthAPIModel model) {
    return AuthEntity(
        userId: model.userId,
        email: model.email,
        phone: model.phone,
        password: model.password);
  }
}