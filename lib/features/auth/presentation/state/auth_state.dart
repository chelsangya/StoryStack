import 'package:story_stack/features/auth/domain/entity/auth_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final String? message;
  final AuthEntity? authEntity;

  AuthState({
    required this.isLoading,
    this.error,
    this.message,
    this.showMessage = false,
    this.authEntity,
  });

  factory AuthState.initialState() {
    return AuthState(
      isLoading: false,
      error: null,
      showMessage: false,
      message: null,
      authEntity: null,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    String? message,
    String? imageName,
    AuthEntity? authEntity,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
      message: message ?? this.message,
      authEntity: authEntity ?? this.authEntity,
    );
  }

  @override
  String toString() => 'AuthState(isLoading: $isLoading, error: $error, )';
}
