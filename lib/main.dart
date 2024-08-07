import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_test/data/datasource/database/database_provider.dart';

import 'data/datasource/database/hive_database.dart';
import 'presentation/page/news/article_list_page.dart';

void main() async {
  await Hive.initFlutter();
  HiveDatabase hiveDb = HiveDatabase();
  await hiveDb.openBox();
  runApp(ProviderScope(
      overrides: [hiveDatabaseProvider.overrideWithValue(hiveDb)],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ArticleListPage(),
    );
  }
}
