import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/news_model.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({super.key, required this.article,});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: SingleChildScrollView( // Allow scrolling for long content
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              article.publishedTime,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${article.source.name}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                 const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('|')),
                if (article.author != null) ...[
                  Text(
                    '${article.author}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ],
            ),


            const SizedBox(height: 16),
            if (article.content != null)
              Text(
                article.content!,style: Theme.of(context).textTheme.bodyMedium,
              )
            else
              InkWell( // Hyperlink to open article in browser
                onTap: () async {
                  final url = article.url;
                  if (await canLaunchUrl(Uri.parse(url))) {
                    // await launchUrl(Uri.parse(url));
                  } else {
                    // Handle the case where the URL can't be launched
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not open article URL')),
                    );
                  }
                },
                child: Text(
                  'Read full article here',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.blue),
                ),
              )
          ],
        ),
      ),
    );
  }
}
