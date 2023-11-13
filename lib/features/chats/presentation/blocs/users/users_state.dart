part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersFailure extends UsersState {
  UsersFailure({required this.message});

  final String message;
}

class UsersData extends UsersState {
  UsersData({required this.users});

  final List<User> users;
}

class UsersLoading extends UsersState {}
