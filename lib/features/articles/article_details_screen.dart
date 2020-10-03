import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:top_stories/components/custom_list_tile.dart';
import 'package:top_stories/core/core.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailsScreen(
    this.article, {
    Key key,
  }) : super(key: key);

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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImage(),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildArticleCategoryAndDate(),
          ),
          if (isNotEmpty(article.title))
            SliverToBoxAdapter(
              child: _buildArticleTitle(context),
            ),
          if (isNotEmpty(article.title))
            SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
          SliverToBoxAdapter(
            child: _buildArticleAbstract(),
          ),
          SliverToBoxAdapter(
            child: _buildBookmark(context),
          ),
          SliverToBoxAdapter(
            child: _buildGoToArticle(context),
          ),
        ],
      ),
    );
  }

  ///Build bookmark list tile
  Widget _buildBookmark(BuildContext context) {
    return CustomListTile(
      icon: Icons.bookmark,
      title: Strings.bookmark,
    );
  }

  ///Build full article list tile
  Widget _buildGoToArticle(BuildContext context) {
    return CustomListTile(
      icon: Icons.web,
      title: Strings.fullArticle,
      onTap: () => launchUrls(scheme: 'https', path: article.url),
    );
  }

  ///Builds the article's title
  Padding _buildArticleTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        article.title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  ///Build article's abstract
  Widget _buildArticleAbstract() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(article.abstractText),
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
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                    placeholder: (BuildContext context, String string) =>
                        Image.asset(
                      Images.placeholder,
                    ),
                  )
                : Container(
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
