part of 'user_cubit.dart';

@immutable
abstract class UserState {
  final User user;
  const UserState({required this.user});
}

class UserInitial extends UserState {
  UserInitial() : super(user: User());
}

class UserUnregistered extends UserState {
  UserUnregistered() : super(user: User());
}

class UserFailure extends UserState {
  final String errorMessage;
  final int errorCode;

  const UserFailure(
      {required this.errorMessage,
      required this.errorCode,
      required super.user});
}

class UserData extends UserState {
  const UserData({required super.user});
}

class UserLoading extends UserState {
  const UserLoading({required super.user});
}

class UserDeleted extends UserState {
  const UserDeleted({required super.user});
}
