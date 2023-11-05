import 'package:clean_architecture_template/injection_container.dart';
import 'package:dio/dio.dart';

import 'data/datasource/_datasource.dart';

mixin ChatsInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // cubits
    // sl.registerLazySingleton(() => SampleCubit(repository: sl()));

    // use cases

    // repositories
    // sl.registerLazySingleton<Repository>(
    //     () => RepositoryImpl(datasource: sl()));

    // data sources
    sl.registerLazySingleton<Datasource>(() => DatasourceImpl(dio: dio));
  }
}
