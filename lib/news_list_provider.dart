import 'dart:core';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'data/model/news_model.dart';
import 'data/model/news_state.dart';
import 'data/repository/news_list_repository.dart';

part 'news_list_provider.g.dart';

@riverpod
class AsyncNewsList extends _$AsyncNewsList {
  @override
  FutureOr<List<Article>> build() async {
    final repository = ref.watch(newsListRepositoryProvider);

    final response = repository.value;
    return switch (response) {
    LoadedState() => response.articles,
    ErrorState() => throw AsyncError(response.message, StackTrace.empty),
    _ => throw const AsyncError('Unknown error', StackTrace.empty),
    };
  }
}