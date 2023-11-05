// import 'package:dio/dio.dart';
//
// class TokenInterceptor extends Interceptor {
//   TokenInterceptor({
//     required this.tokenLocalRepository,
//   });
//
//   final TokenLocalRepository tokenLocalRepository;
//
//   @override
//   Future<void> onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final token = await tokenLocalRepository.getToken();
//     token.fold(
//       (failure) => null, // throw GetTokenException(),
//       (data) => {
//         if (options.headers.containsKey('Authorization'))
//           {options.headers['Authorization'] = '$data'}
//         else
//           {
//             options.headers.putIfAbsent('Authorization', () => '$data'),
//           }
//       },
//     );
//     super.onRequest(options, handler);
//   }
// }

import 'package:clean_architecture_template/core/helper/shared_preferences.dart';
import 'package:dio/dio.dart';

/// INSERT TOKEN FROM SHARED PREFERENCES TO REQUEST HEADER IN NEEDED

class TokenInterceptor extends Interceptor {
  TokenInterceptor({
    required this.sharedPreferencesRepository,
  });

  final SharedPreferencesRepository sharedPreferencesRepository;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String token = sharedPreferencesRepository.readString(
          key: SharedPreferencesKeys.token,
        ) ??
        "";

    print(token);
    print('token');

    if (token != "") {
      if (options.headers.containsKey('Authorization')) {
        options.headers['Authorization'] = 'Token $token';
      } else {
        options.headers.putIfAbsent('Authorization', () => 'Token $token');
      }
      print(options.headers);
    }

    super.onRequest(options, handler);
  }
}
