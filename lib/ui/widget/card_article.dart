import 'package:flutter/material.dart';
import 'package:newsapp/data/model/article.dart';
import 'package:newsapp/common/style.dart';

import '../../common/navigation.dart';
import '../detail_page.dart';

class CardArticles extends StatelessWidget {
  final Article article;

  const CardArticles({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Hero(
          tag: article.urlToImage!,
          child: Image.network(
            article.urlToImage!,
            width: 100,
          ),
        ),
        minLeadingWidth: 100,
        title: Text(
          article.title,
        ),
        subtitle: Text(article.author!),
        onTap: () =>
            Navigation.intentWithData(ArticleDetailPage.routeName, article),
      ),
    );
  }
}
