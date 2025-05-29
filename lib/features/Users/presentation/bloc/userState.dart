import 'package:inventigacionflutter/core/error/failures.dart';
import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';

sealed class UserState {}

final class UserInitialState extends UserState {}

final class UserLoadingState extends UserState {}

final class UserSuccessState extends UserState {
  final User user;

  UserSuccessState({required this.user});
}

final class UserListSuccessState extends UserState {
  final List<User> users;

  UserListSuccessState({required this.users});
}

final class UserErrorState extends UserState {
  final Failure failure;

  UserErrorState({required this.failure});
}