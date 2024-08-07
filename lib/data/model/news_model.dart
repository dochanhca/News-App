import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';

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

  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json['source']),
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content'],
      );

  String get publishedDate {
    final formatter = DateFormat('dd/MM/yyyy');
    try {
      String formatted = formatter.format(DateTime.parse(publishedAt));
      return formatted;
    } catch (e) {
      log('parse publishedAt($publishedAt) error: e');
      return '';
    }
  }

  String get publishedTime {
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    try {
      String formatted = formatter.format(DateTime.parse(publishedAt));
      return formatted;
    } catch (e) {
      log('parse publishedAt($publishedAt) error: e');
      return '';
    }
  }
}

class Source {
  Source({
     this.id,
     this.name,
  });

  final String? id;
  final String? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json['id'],
        name: json['name'],
      );
}
