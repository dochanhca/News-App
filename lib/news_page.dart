import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/model/news_model.dart';
import 'news_list_provider.dart';

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsList = ref.watch(asyncNewsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pull to refresh')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(asyncNewsListProvider.future),
        child: ListView(
          children: [
            switch (newsList) {
              AsyncValue<List<Article>>(:final valueOrNull?) =>
                ListView.builder(
                  itemCount: valueOrNull.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(valueOrNull[index].title),
                  ),
                ),
              AsyncValue(:final error?) => Text('Error: $error'),
              _ => const CircularProgressIndicator(),
            },
          ],
        ),
      ),
    );
  }
}
