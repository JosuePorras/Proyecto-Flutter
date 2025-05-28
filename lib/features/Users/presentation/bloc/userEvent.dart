import 'package:inventigacionflutter/features/Users/domain/entities/user.dart';

sealed class UserEvent {}

class FetchUsersEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final User user;
  AddUserEvent({required this.user});
}

class UpdateUserEvent extends UserEvent {
  final User user;
  UpdateUserEvent({required this.user});
}

class DeleteUserEvent extends UserEvent {
  final int id;
  DeleteUserEvent({required this.id});
}

class GetUserByIdEvent extends UserEvent {
  final int id;
  GetUserByIdEvent({required this.id});
}

