import 'dart:convert';

class NewsApiError {
  NewsApiError({
    required this.status,
    required this.code,
    required this.message,
  });

  final String? status;
  final String? code;
  final String? message;

  factory NewsApiError.fromRawJson(String str) =>
      NewsApiError.fromJson(json.decode(str));

  factory NewsApiError.fromJson(Map<String, dynamic> json) => NewsApiError(
        status: json['status'],
        code: json['code'],
        message: json['message'],
      );
}

class NewsApiResponse {
  NewsApiResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  factory NewsApiResponse.fromRawJson(String str) =>
      NewsApiResponse.fromJson(json.decode(str));

  factory NewsApiResponse.fromJson(Map<String, dynamic> json) =>
      NewsApiResponse(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: json['articles'] == null
            ? []
            : List<Article>.from(
                json['articles'].map((article) => Article.fromJson(article))),
      );
}

class Article {
  Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  late final Source source;
  late final String? author;
  late final String title;
  late final String? description;
  late final String url;
  late final String? urlToImage;
  late final String publishedAt;
  late final String? content;

  Article.fromJson(Map<String, dynamic> json) {
    source = Source.fromJson(json['source']);
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  late final String id;
  late final String name;

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
