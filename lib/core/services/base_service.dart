import 'package:dio/dio.dart';

class BaseService {
  late final Dio dio;

  BaseService() {
    _initializeDio();
    //_initializeAuthorizationToken();

    dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  void _initializeDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.openweathermap.org/data/2.5/",
        connectTimeout: const Duration(seconds: 45),
        receiveTimeout: const Duration(seconds: 45),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        validateStatus: (status) => true,
      ),
    );
  }

  // Future<void> _initializeAuthorizationToken() async {
  //   dio.interceptors.add(InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //       if (!options.headers.containsKey('Authorization')) {
  //         final token = await AppSharedPreferences().getIDToken();
  //         if (token != null) {
  //           options.headers['Authorization'] = 'Bearer $token';
  //         }
  //       }
  //       return handler.next(options);
  //     },
  //     onError: (error, handler) {
  //       _handleError(error);
  //       return handler.next(error);
  //     },
  //   ));
  // }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }
}