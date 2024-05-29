import 'package:meta/meta.dart';

class HttpResponse<T> { 

  
  final T? data;
  final HttpError? error;

  HttpResponse({required this.data, required this.error});

  static HttpResponse<T> success<T>(T data) =>
      HttpResponse(data: data, error: null);

  
  static HttpResponse<T> fail<T>({
    required int statusCode,
    required String message,
    dynamic data,
  }) =>
      HttpResponse(
          data: null,
          error:
              HttpError(statusCode: statusCode, message: message, data: data));
}

class HttpError{
  final int statusCode;
  final String message;
  final dynamic data;

  HttpError({required this.statusCode, required this.message, required this.data});
}