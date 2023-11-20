part of 'chats_cubit.dart';

@immutable
abstract class ChatsState {}

class ChatsInitial extends ChatsState {}

class ChatsFailure extends ChatsState {
  ChatsFailure({required this.message});

  final String message;
}

class ChatsData extends ChatsState {
  ChatsData({required this.chats});

  final List<Chat> chats;
}

class ChatsCreated extends ChatsState {}

class ChatsLoading extends ChatsState {}
