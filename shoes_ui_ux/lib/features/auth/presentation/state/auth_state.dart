import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final List<AuthEntity>? users;
  final AuthEntity? user; // Added AuthEntity user field

  AuthState({
    this.users,
    required this.isLoading,
    required this.error,
    required this.showMessage,
    this.user, // Initialized user field
  });

  factory AuthState.initialState() => AuthState(
        users: [],
        isLoading: false,
        error: null,
        showMessage: false,
        user: null, // Initialized user field
      );

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<AuthEntity>? users,
    AuthEntity? user, // Added user parameter in copyWith method
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
      users: users ?? this.users,
      user: user ?? this.user, // Updated user field in copyWith method
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error, showMessage: $showMessage)';
}
