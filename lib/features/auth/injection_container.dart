import 'package:clean_architecture_template/features/auth/data/datasource/auth_datasource.dart';
import 'package:clean_architecture_template/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecture_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_template/features/auth/presentation/blocs/check_otp_cubit/check_otp_cubit.dart';
import 'package:clean_architecture_template/features/auth/presentation/blocs/send_otp_cubit/send_otp_cubit.dart';
import 'package:clean_architecture_template/features/auth/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:clean_architecture_template/injection_container.dart';
import 'package:dio/dio.dart';

mixin AuthInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // // cubits
    sl.registerFactory(() => SendOtpCubit(repository: sl()));
    sl.registerFactory(() => CheckOtpCubit(repository: sl()));

    sl.registerLazySingleton(() => UserCubit(
          repository: sl(),
          sharedPrefsRepository: sl(),
        ));

    // repositories
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authDatasource: sl(),
      ),
    );

    // data sources
    sl.registerLazySingleton<AuthDatasource>(
      () => AuthDatasourceImpl(
        dio: dio,
        sharedPreferencesRepository: sl(),
      ),
    );

    // use case
  }
}
