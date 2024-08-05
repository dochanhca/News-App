import 'package:news_test/data/model/news_model.dart';

sealed class NewsState {}

class LoadedState extends NewsState {
  LoadedState(this.articles);

  final List<Article> articles;
}

class ErrorState extends NewsState {
  ErrorState({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;
}