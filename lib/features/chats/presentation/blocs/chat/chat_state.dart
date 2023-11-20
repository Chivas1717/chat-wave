part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatFailure extends ChatState {
  ChatFailure({required this.message});

  final String message;
}

class ChatData extends ChatState {
  ChatData({required this.chat});

  final ChatFull chat;
}

class ChatCreated extends ChatState {}

class ChatLoading extends ChatState {}
