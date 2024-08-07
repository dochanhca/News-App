import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/model/news_model.dart';
import '../../detail/article_detail_page.dart';

class ItemArticle extends ConsumerWidget {
  const ItemArticle({
    super.key,
    required this.article,
  });

  final Article article;

  Widget get defaultImage => Image.asset(
        'assets/img_default_small.png',
        color: Colors.grey,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ArticleDetailPage(article: article)));
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Container(
                                  color: Colors.grey.shade200,
                                  child: article.urlToImage == null ||
                                          article.urlToImage!.isEmpty
                                      ? defaultImage
                                      : Image(
                                          image: CachedNetworkImageProvider(
                                              article.urlToImage ?? ''),
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (_, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return defaultImage;
                                          },
                                          errorBuilder: (context, _, __) =>
                                              defaultImage,
                                        )),
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            article.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: 'Source: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.grey),
                                        children: [
                                      TextSpan(
                                          text: article.source.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ))
                                    ])),
                                Text(article.publishedDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.black,
                                        ))
                              ])
                        ],
                      ))
                ],
              ),
            )));
  }
}
