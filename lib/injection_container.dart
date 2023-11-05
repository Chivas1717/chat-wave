import 'package:clean_architecture_template/core/helper/shared_preferences.dart';
import 'package:clean_architecture_template/core/interceptors/response_interceptor.dart';
import 'package:clean_architecture_template/core/interceptors/token_interceptor.dart';
import 'package:clean_architecture_template/features/auth/injection_container.dart';
import 'package:clean_architecture_template/features/chats/injection_container.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_config.dart';
import 'core/interceptors/error_logger_interceptor.dart';
import 'core/network/network_info.dart';

final sl = GetIt.instance;

const globalDio = 'global';

class InjectionContainer extends Injector with AuthInjector, ChatsInjector {}

abstract class Injector {
  @mustCallSuper
  Future<void> init() async {
    // final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();

    sl.registerLazySingleton<SharedPreferencesRepository>(
        () => SharedPreferencesRepository());

    // await sl<SharedPreferencesRepository>().init();
    sl.registerLazySingleton<AppConfig>(() => AppConfig.init);

    sl.registerLazySingleton<Dio>(
      () {
        final dio = Dio(BaseOptions(
          baseUrl: sl<AppConfig>().api,
          connectTimeout: const Duration(milliseconds: 15000),
          receiveTimeout: const Duration(milliseconds: 15000),
        ));
        dio.options.headers = {
          "content-type": "application/json",
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
          // "App-Timezone": currentTimeZone
        };
        dio.interceptors.add(ErrorLoggerInterceptor());
        // if (!sl<AppConfig>().isProductionEnvironment) {

        // }

        dio.interceptors.addAll([
          TokenInterceptor(sharedPreferencesRepository: sl()),
          // ErrorNetworkInterceptor(),
          ResponseInterceptor(),
        ]);
        dio.interceptors.add(PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ));

        return dio;
      },
      instanceName: globalDio,
    );

    await sl<SharedPreferencesRepository>().init();

    //Core
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    //External
    sl.registerLazySingleton(() => InternetConnectionChecker());
  }
}
