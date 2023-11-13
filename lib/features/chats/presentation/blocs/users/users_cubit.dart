import 'package:bloc/bloc.dart';
import 'package:clean_architecture_template/features/auth/domain/entities/user.dart';
import 'package:clean_architecture_template/features/chats/domain/repositories/chats_repository.dart';
import 'package:flutter/widgets.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({
    required this.repository,
  }) : super(UsersInitial());

  final ChatsRepository repository;

  void getUsers() async {
    emit(UsersLoading());

    final poolResult = await repository.getUsers();

    poolResult.fold(
      (failure) => emit(UsersFailure(message: failure.errorMessage)),
      (users) => emit(UsersData(users: users)),
    );
  }
}
