import 'dart:convert';

import 'package:dio/dio.dart';

import '../../constant.dart';

/// Model for the response returned from HTTP Cache
class CachedResponse {
  /// Creates an instance of [CachedResponse]
  CachedResponse({
    required this.data,
    required this.cachedTime,
    required this.statusCode,
    required this.headers,
  });

  /// The age of the cached response
  ///
  /// This is used to determine whether the cache has expired or not
  /// based on the [Configs.maxCacheAge] value
  ///
  /// see [isValid]
  final DateTime cachedTime;

  final dynamic data;

  final int statusCode;

  final Headers headers;

  /// Determines if a cached response has expired
  ///
  /// A cached response is expired when its [cachedTime] is older
  /// than the [Constant.maxCacheAge]
  bool get isValid =>
      DateTime.now().isBefore(cachedTime.add(Constant.maxCacheTime));

  /// Creates an instance of [CachedResponse] parsed raw data
  factory CachedResponse.fromJson(Map<String, dynamic> data) {
    return CachedResponse(
      data: data['data'],
      cachedTime: DateTime.parse(data['cachedTime'] as String),
      statusCode: data['statusCode'] as int,
      headers: Headers.fromMap(
        Map<String, List<dynamic>>.from(
          json.decode(json.encode(data['headers'])) as Map<dynamic, dynamic>,
        ).map(
          (k, v) => MapEntry(k, List<String>.from(v)),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': data,
      'cachedTime': cachedTime.toString(),
      'statusCode': statusCode,
      'headers': headers.map,
    };
  }

  Response<dynamic> buildResponse(RequestOptions options) {
    return Response<dynamic>(
      data: data,
      headers: headers,
      requestOptions: options.copyWith(extra: options.extra),
      statusCode: statusCode,
    );
  }
}
