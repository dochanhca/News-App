import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constant.dart';
import '../../model/news_model.dart';
import '../../model/news_state.dart';
import '../database/database_provider.dart';
import '../database/hive_database.dart';
import 'cache_interceptor.dart';

part 'news_api.g.dart';

@riverpod
NewsApi newsApi(
  NewsApiRef ref, {
  bool enableCache = true,
}) {
  if (enableCache = true) {
    final database = ref.watch(hiveDatabaseProvider);

    return NewsApi(
      database: database,
      enableCaching: enableCache,
    );
  }
  return NewsApi(enableCaching: false);
}

class NewsApi {
  NewsApi({
    HiveDatabase? database,
    bool enableCaching = true,
  }) : assert((enableCaching == false || database != null),
            'when enable cache, database can not null') {
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/v2/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    if (enableCaching) {
      dio.interceptors.add(CacheInterceptor(database!));
    }
  }

  late final Dio dio;

  Future<NewsState> fetchNewsList({
    String keyword = '',
    CancelToken? cancelToken,
  }) async {
    final url =
        "top-headlines?country=us&apiKey=${Constant.newsApiKey}&q=$keyword";
    try {
      final response = await dio.get(
        url,
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200) {
        final newsResponse = NewsApiResponse.fromRawJson(response.data);
        return LoadedState(newsResponse.articles);
      } else {
        final newsApiError = NewsApiError.fromRawJson(response.data);
        return ErrorState(
          code: newsApiError.code ?? response.statusCode?.toString() ?? '502',
          message:
              newsApiError.message ?? response.statusMessage ?? 'unKnow error',
        );
      }
    } catch (e) {
      return ErrorState(code: '999', message: 'unKnow error');
    }
  }
}
