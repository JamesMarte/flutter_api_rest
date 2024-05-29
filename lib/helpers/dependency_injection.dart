import 'package:dio/dio.dart';
import 'package:flutter_rest_api/api/account_api.dart';
import 'package:flutter_rest_api/api/authentication_api.dart';
import 'package:flutter_rest_api/data/authentication_client.dart';
import 'package:flutter_rest_api/helpers/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection{
  static void initialize(){
    final Dio dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.13:9000'),
    );
    Http http = Http
    (dio: dio,
      logsEnabled: true,
    );

  final secureStorage = FlutterSecureStorage();

    final  authenticationAPI = AuthenticationAPI(http: http);
    final  authenticationClient = AuthenticationClient(secureStorage: secureStorage, authenticationAPI);
    final  accountAPI = AccountAPI(authenticationClient, http: http);

    GetIt.instance.registerSingleton<AuthenticationAPI>(authenticationAPI);
    GetIt.instance.registerSingleton<AuthenticationClient>(authenticationClient);
    GetIt.instance.registerSingleton<AccountAPI>(accountAPI);
  }
}