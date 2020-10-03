import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:top_stories/core/core.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard(this.article);

  ///Getter for the image url, iterates over the article image options and returns the first non-null one
  String get imageUrl {
    ArticleMultimedia media;
    for (int i = 0; i < ArticleImageSize.values.length; i++) {
      media = article.articleMultimedia?.firstWhere(
          (element) => element?.imageSize == ArticleImageSize.values[i]);
      if (!(media == null)) return media?.url;
    }

    return media?.url;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildImage(),
          _buildArticleCategoryAndDate(),
          _buildArticleTitle(context),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  ///Builds the article's title
  Padding _buildArticleTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              article.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          )
        ],
      ),
    );
  }

  ///Builds the article's category and date
  Padding _buildArticleCategoryAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(article.section?.toUpperCase()),
          Text(
            getStrDate(article.publishedDate, pattern: 'MMMM yy hh:mm a'),
            style: TextStyle(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  ///Builds the image for the article, if the image is null a placeholder takes its place
  Row _buildImage() {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            child: (article?.articleMultimedia != null &&
                    article.articleMultimedia.isNotEmpty)
                ? CachedNetworkImage(
                    height: 200,
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                    placeholder: (BuildContext context, String string) =>
                        Image.asset(Images.placeholder, height: 200),
                  )
                : Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          Images.placeholder,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}