import 'package:bloc/bloc.dart';
import 'package:inventigacionflutter/features/Users/domain/use_cases/add_user.dart';
import 'package:inventigacionflutter/features/Users/domain/use_cases/delete_user.dart';
import 'package:inventigacionflutter/features/Users/domain/use_cases/get_user_by_id.dart';
import 'package:inventigacionflutter/features/Users/domain/use_cases/get_users.dart';
import 'package:inventigacionflutter/features/Users/domain/use_cases/update_user.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userEvent.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userState.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AddUserUseCase _addUserUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  final UserDeleteUseCase _deleteUserUseCase;
  final GetAllUsersUseCase _getAllUsersUseCase;
  final GetUserByIdUseCase _getUserByIdUseCase;

  UserBloc(
      this._addUserUseCase,
      this._updateUserUseCase,
      this._deleteUserUseCase,
      this._getAllUsersUseCase,
      this._getUserByIdUseCase,
      ) : super(UserInitialState()) {
    on<FetchUsersEvent>((event, emit) async {
      emit(UserLoadingState());
      final result = await _getAllUsersUseCase();
      result.fold(
            (failure) => emit(UserErrorState(failure: failure)),
            (users) => emit(UserListSuccessState(users: users)),
      );
    });

    on<AddUserEvent>((event, emit) async {
      final result = await _addUserUseCase(event.user);
      result.fold(
            (failure) => emit(UserErrorState(failure: failure)),
            (_) => add(FetchUsersEvent()), // Refresh the user list
      );
    });

    on<UpdateUserEvent>((event, emit) async {
      final result = await _updateUserUseCase(event.user);
      result.fold(
            (failure) => emit(UserErrorState(failure: failure)),
            (_) => add(FetchUsersEvent()), // Refresh the user list
      );
    });

    on<DeleteUserEvent>((event, emit) async {
      final result = await _deleteUserUseCase(event.id);
      result.fold(
            (failure) => emit(UserErrorState(failure: failure)),
            (_) => add(FetchUsersEvent()), // Refresh the user list
      );
    });

    on<GetUserByIdEvent>((event, emit) async {
      emit(UserLoadingState());
      final result = await _getUserByIdUseCase(event.id);
      result.fold(
            (failure) => emit(UserErrorState(failure: failure)),
            (user) => emit(UserSuccessState(user: user)),
      );
    });
  }
}
