import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/news_model.dart';
import 'article_list_provider.dart';
import 'widget/item_article.dart';
import 'widget/error_widget.dart' as error_widget;
import 'widget/article_search_bar.dart';

class ArticleListPage extends ConsumerWidget {
  const ArticleListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(asyncArticleListProvider);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Latest Articles'),
        centerTitle: true,),
        body: SafeArea(
          bottom: false,
          child: switch (articles) {
            AsyncValue<List<Article>>(:final valueOrNull?) => Column(
                children: [
                  const ArticleSearchBar(),
                  Expanded(
                    child: valueOrNull.isEmpty
                        ? Center(
                            child: Text(
                            'No matching news found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ))
                        : RefreshIndicator(
                            onRefresh: () =>
                                ref.refresh(asyncArticleListProvider.future),
                            child: ListView.separated(
                              itemCount: valueOrNull.length,
                              itemBuilder: (context, index) =>
                                  ItemArticle(article: valueOrNull[index]),
                              separatorBuilder: (_, __) => Divider(
                                height: 1,
                                color: Colors.grey.shade200,
                                indent: 16,
                                endIndent: 16,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            AsyncError<List<Article>>(:final AsyncError error) =>
              error_widget.ErrorWidget(
                title: 'Oops! Something went wrong.',
                description: error.error.toString(),
              ),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ));
  }
}
