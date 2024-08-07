import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../datasource/network/news_api.dart';
import '../model/news_state.dart';

part 'article_list_repository.g.dart';

class AbortedException implements Exception {}

@riverpod
Future<NewsState> articleListRepository(ArticleListRepositoryRef ref) async {
    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);

    // Debouncing the request.
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (cancelToken.isCancelled) throw AbortedException();

    final newsApi = ref.watch(newsApiProvider(enableCache: true));
    return newsApi.fetchNewsList(cancelToken: cancelToken);
  }