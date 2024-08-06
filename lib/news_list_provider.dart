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

    return repository.map(
      data: (data) {
        final state = data.value;
        return switch (state) {
          LoadedState() => state.articles,
          ErrorState() => throw AsyncError(state.message, StackTrace.empty),
        };
      },
      error: (error) => throw AsyncError(error.toString(), StackTrace.empty),
      loading: (_) => throw const AsyncValue
          .loading(), // Or handle loading differently if needed
    );
  }
}
