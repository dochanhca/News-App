import 'dart:async';
import 'dart:core';

import 'package:news_test/data/repository/article_list_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/model/news_model.dart';
import '../../../data/model/news_state.dart';

part 'article_list_provider.g.dart';

@riverpod
class AsyncArticleList extends _$AsyncArticleList {
  List<Article> originalList = [];
  Timer? _debounceTimer;

  @override
  FutureOr<List<Article>> build() async {
    ref.onDispose(() => _debounceTimer?.cancel());
    ref.invalidate(articleListRepositoryProvider);
    final newsState = await ref.watch(articleListRepositoryProvider.future);

    if (newsState is LoadedState) {
      originalList = (newsState).articles;
      return originalList;
    } else if (newsState is ErrorState) {
      throw AsyncError(newsState.message, StackTrace.empty);
    }
    throw UnimplementedError("Unhandled NewsState: $newsState");
  }

  void searchByTitle(String title) {
    if (_debounceTimer != null) {
      _debounceTimer!.cancel(); // Cancel any existing timer
    }

    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      // Adjust delay as needed
      if (title.isEmpty) {
        state = AsyncData(originalList);
      } else {
        final result = originalList
            .where((article) =>
                article.title.toLowerCase().contains(title.toLowerCase()))
            .toList();
        state = AsyncData(result);
      }
    });
  }
}
