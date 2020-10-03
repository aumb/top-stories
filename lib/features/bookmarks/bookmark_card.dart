import 'package:flutter/material.dart';
import 'package:top_stories/core/core.dart';

class BookmarkCard extends StatelessWidget {
  final Article article;
  final Function onTap;

  const BookmarkCard(
    this.article, {
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArticleCategory(),
            _buildArticleDate(),
            SizedBox(height: 16),
            if (isNotEmpty(article.title))
              Expanded(child: _buildArticleTitle(context)),
            if (isNotEmpty(article.title)) SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  ///Builds the article's title
  Padding _buildArticleTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        article.title,
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  ///Builds the article's category
  Padding _buildArticleCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Text(article.section?.toUpperCase()),
    );
  }

  ///Builds the article's date
  Padding _buildArticleDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        getStrDate(article.publishedDate, pattern: 'MMMM yy hh:mm a'),
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
    );
  }
}
