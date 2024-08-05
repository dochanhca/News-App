import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../datasource/network/news_api.dart';
import '../model/news_model.dart';

part 'news_repository.g.dart';

class AbortedException implements Exception {}

@riverpod
class NewsList extends _$NewsList {
  @override
  Future<List<Article>> build() async {
    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);

    // Debouncing the request.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (cancelToken.isCancelled) throw AbortedException();

    final newsApi = ref.watch(newsApiProvider(enableCache: true));
    final newsState = newsApi.fetchNewsList(cancelToken: cancelToken);
    return AsyncError(error, stackTrace);
  }

  Future<List<Article>> searchNews(String keywork) {
    return Future.value([]);
  }
}