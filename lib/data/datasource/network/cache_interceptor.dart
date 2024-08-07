import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../model/cached_response.dart';
import '../database/hive_database.dart';

class CacheInterceptor implements Interceptor {
  CacheInterceptor(this.database);

  final HiveDatabase database;

  /// storage key: 'https://newsapi.org/v2/top-headlines?country=us&apiKey=e5867d0db77b4395891bb4c4a73066bb'
  String createBoxKey({
    required String baseUrl,
    required String path,
  }) =>
      baseUrl + path;

  Future<bool> isNetworkConnected() async {
    try {
      final result = await InternetAddress.lookup('newsapi.org');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      log('Can not connect to https://newsapi.org');
    }
    return false;
  }

  /// Method that intercepts Dio error
  @override
  void onError(DioException exception, ErrorInterceptorHandler handler) {
    final databaseKey = createBoxKey(
      baseUrl: exception.requestOptions.baseUrl,
      path: exception.requestOptions.path,
    );
    if (database.has(databaseKey)) {
      final cachedResponse = _getCachedResponse(databaseKey);
      if (cachedResponse != null) {
        log('Retrieved response from cache');
        final response = cachedResponse.buildResponse(exception.requestOptions);
        return handler.resolve(response);
      }
    }
    return handler.next(exception);
  }

  /// Method that intercepts Dio request
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final databaseKey = createBoxKey(
      baseUrl: options.baseUrl,
      path: options.path,
    );
    bool hasNetwork = await isNetworkConnected();

    /// if can't connect to https://newsapi.org/, try to get news from db
    if (!hasNetwork && database.has(databaseKey)) {
      final cachedResponse = _getCachedResponse(databaseKey);
      if (cachedResponse != null) {
        log('Retrieved response from cache on Request');
        final response = cachedResponse.buildResponse(options);
        return handler.resolve(response);
      }
    }
    return handler.next(options);
  }

  /// Method that intercepts Dio response
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.statusCode != null && response.statusCode! == 200) {
      log('Retrieved response from: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      log('Response data: ${response.data}');

      final cachedResponse = CachedResponse(
        data: response.data,
        headers: Headers.fromMap(response.headers.map),
        cachedTime: DateTime.now(),
        statusCode: response.statusCode!,
      );
      final databaseKey = createBoxKey(
        baseUrl: response.requestOptions.baseUrl,
        path: response.requestOptions.path,
      );
      database.set(databaseKey, cachedResponse.toJson());
    }
    return handler.next(response);
  }

  CachedResponse? _getCachedResponse(String databaseKey) {
    final dynamic rawCachedResponse = database.get(databaseKey);
    try {
      final cachedResponse = CachedResponse.fromJson(
          json.decode(json.encode(rawCachedResponse)) as Map<String, dynamic>);
      if (cachedResponse.isValid) {
        return cachedResponse;
      } else {
        log('Cache is outdated, deleting it...');
        database.remove(databaseKey);
        return null;
      }
    } catch (e) {
      log('Error retrieving response from cache');
      log('e: $e');
      return null;
    }
  }
}
