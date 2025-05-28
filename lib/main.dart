import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inventigacionflutter/features/Users/data/datasources/user_api_remote.dart';
import 'package:inventigacionflutter/features/Users/data/repositories/users_repository_impl.dart';
import 'package:inventigacionflutter/features/Users/domain/repositories/user_repository.dart';
import 'package:inventigacionflutter/features/Users/domain/use_cases/add_user.dart';
import 'package:inventigacionflutter/features/Users/domain/use_cases/delete_user.dart';
import 'package:inventigacionflutter/features/Users/domain/use_cases/get_user_by_id.dart';
import 'package:inventigacionflutter/features/Users/domain/use_cases/get_users.dart';
import 'package:inventigacionflutter/features/Users/domain/use_cases/update_user.dart';
import 'package:inventigacionflutter/features/Users/presentation/bloc/userBloc.dart';
import 'app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final dio = Dio();

  //dataSource
  final UserApiRemote userApiRemote = UserApiRemoteImpl(dio);

  //Repository
  final UserRepository userRepository = UsersRepositoryImpl(userApiRemote: userApiRemote);

  //Use Cases
  final AddUserUseCase addUserUseCase = AddUserUseCase(userRepository: userRepository);
  final GetAllUsersUseCase getAllUsersUseCase = GetAllUsersUseCase(userRepository: userRepository);
  final UpdateUserUseCase updateUserUseCase = UpdateUserUseCase(userRepository: userRepository);
  final UserDeleteUseCase deleteUserUseCase = UserDeleteUseCase(userRepository: userRepository);
  final GetUserByIdUseCase getUserByIdUseCase = GetUserByIdUseCase(userRepository: userRepository);

  //Bloc

  final UserBloc userBloc = UserBloc(
    addUserUseCase, 
    updateUserUseCase, 
    deleteUserUseCase, 
    getAllUsersUseCase, 
    getUserByIdUseCase
    );


  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) => userBloc,
        ),
      ],
      child: const MyApp()
    ),
  );
}