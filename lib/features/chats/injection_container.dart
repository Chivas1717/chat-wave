import 'package:clean_architecture_template/features/chats/data/datasource/chats_datasource.dart';
import 'package:clean_architecture_template/features/chats/data/repositories/chats_repository_impl.dart';
import 'package:clean_architecture_template/features/chats/domain/repositories/chats_repository.dart';
import 'package:clean_architecture_template/features/chats/presentation/blocs/chat/chat_cubit.dart';
import 'package:clean_architecture_template/features/chats/presentation/blocs/chats/chats_cubit.dart';
import 'package:clean_architecture_template/features/chats/presentation/blocs/users/users_cubit.dart';
import 'package:clean_architecture_template/injection_container.dart';
import 'package:dio/dio.dart';

mixin ChatsInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // cubits
    sl.registerLazySingleton(() => UsersCubit(repository: sl()));
    sl.registerLazySingleton(() => ChatsCubit(repository: sl()));
    sl.registerLazySingleton(() => ChatCubit(repository: sl()));

    // use cases

    // repositories
    sl.registerLazySingleton<ChatsRepository>(
        () => ChatsRepositoryImpl(chatsDatasource: sl()));

    // data sources
    sl.registerLazySingleton<ChatsDatasource>(
        () => ChatsDatasourceImpl(dio: dio));
  }
}
