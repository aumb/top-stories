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
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                width: 5,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                if (isNotEmpty(article.section)) _buildArticleCategory(),
                if (article.publishedDate != null) _buildArticleDate(context),
                SizedBox(height: 8),
                if (isNotEmpty(article.title))
                  Expanded(child: _buildArticleTitle(context)),
                SizedBox(height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildArticleTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        article.title,
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }

  Padding _buildArticleCategory() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
      child: Text(article.section?.toUpperCase()),
    );
  }

  Padding _buildArticleDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        getStrDate(article.publishedDate, pattern: 'MMMM yy hh:mm a'),
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
