import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_test/presentation/page/news/article_list_provider.dart';


class ArticleSearchBar extends ConsumerStatefulWidget {
  const ArticleSearchBar({super.key});

  @override
  ConsumerState<ArticleSearchBar> createState() => _NewsSearchBarState();
}

class _NewsSearchBarState extends ConsumerState<ArticleSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  bool hideClearCTA = true;

  @override
  void initState() {
    _textEditingController.addListener(() {
      final isTextEmpty = _textEditingController.text.isEmpty;
      ref.read(asyncArticleListProvider.notifier).searchByTitle(_textEditingController.text);
      if (isTextEmpty != hideClearCTA) {
        setState(() {
          hideClearCTA = isTextEmpty;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        controller: _textEditingController,
        padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16)),
        elevation: const WidgetStatePropertyAll<double>(3.0),
        leading: const Icon(Icons.search),
        hintText: 'search news',
        hintStyle:
            const WidgetStatePropertyAll<TextStyle>(TextStyle(color: Colors.grey)),
        trailing: hideClearCTA
            ? null
            : <Widget>[
                Tooltip(
                  message: 'Clear text',
                  child: IconButton(
                    onPressed: () {
                      _textEditingController.clear();
                    },
                    icon: const Icon(Icons.clear_rounded),
                  ),
                )
              ],
      ),
    );
  }
}
