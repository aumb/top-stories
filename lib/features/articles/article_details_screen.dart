import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:top_stories/components/custom_list_tile.dart';
import 'package:top_stories/core/core.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final Article article;

  ArticleDetailsScreen(
    this.article, {
    Key key,
  }) : super(key: key);

  @override
  _ArticleDetailsScreenState createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ArticleController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ArticleController(widget.article);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _controller.isLoadingStream,
        builder: (context, snapshot) {
          return Scaffold(
            key: _scaffoldKey,
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
                if (isNotEmpty(widget.article.title))
                  SliverToBoxAdapter(
                    child: _buildArticleTitle(),
                  ),
                if (isNotEmpty(widget.article.title))
                  SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                SliverToBoxAdapter(
                  child: _buildArticleAbstract(),
                ),
                SliverToBoxAdapter(
                  child: _buildBookmark(),
                ),
                SliverToBoxAdapter(
                  child: _buildGoToArticle(),
                ),
              ],
            ),
          );
        });
  }

  ///Getter for the image url, iterates over the article image options and returns the first non-null one
  String get imageUrl {
    ArticleMultimedia media;
    for (int i = 0; i < ArticleImageSize.values.length; i++) {
      media = widget.article.articleMultimedia?.firstWhere(
          (element) => element?.imageSize == ArticleImageSize.values[i]);
      if (!(media == null)) return media?.url;
    }

    return media?.url;
  }

  ///Getter for checking if the article is bookmarked
  bool get isFavorite => _controller.isFavorite();

  ///Build bookmark list tile
  Widget _buildBookmark() {
    return CustomListTile(
        icon: Icons.bookmark,
        iconColor: isFavorite ? Color.fromRGBO(237, 155, 0, 1) : null,
        title: isFavorite ? Strings.removeBookmark : Strings.bookmark,
        onTap: () async {
          final SnackBar snackBar = _buildSnackBar();

          _controller.isLoading = true;
          isFavorite
              ? await BookmarkController()
                  .removeBookmarkedArticle(widget.article)
              : await BookmarkController().bookmarkArticle(widget.article);
          _controller.isLoading = false;

          _scaffoldKey.currentState.showSnackBar(snackBar);
        });
  }

  ///Builds a snackbar depending on the state of the bookmarking. If the bookmarking succeeds
  ///A success snackbar is displayed with the option to undo, if it does not succeed an snackbar
  ///is displayed with an option to retry
  SnackBar _buildSnackBar() {
    if (BookmarkController().pageState == PageState.error) {
      return SnackBar(
        content: Text(Strings.bookmarkError),
        action: SnackBarAction(
            label: Strings.retry,
            onPressed: () async {
              _controller.isLoading = true;
              isFavorite
                  ? await BookmarkController()
                      .removeBookmarkedArticle(widget.article)
                  : await BookmarkController().bookmarkArticle(widget.article);
              _controller.isLoading = false;
            }),
      );
    } else {
      return SnackBar(
        content: Text(
            isFavorite ? Strings.removedBookmark : Strings.addedToBookmarks),
        action: SnackBarAction(
            label: Strings.undo,
            onPressed: () {
              _controller.isLoading = true;
              isFavorite
                  ? BookmarkController().removeBookmarkedArticle(widget.article)
                  : BookmarkController().bookmarkArticle(widget.article);
              _controller.isLoading = false;
            }),
      );
    }
  }

  ///Build full article list tile
  Widget _buildGoToArticle() {
    return CustomListTile(
      icon: Icons.web,
      title: Strings.fullArticle,
      onTap: () => launchUrls(scheme: 'https', path: widget.article.url),
    );
  }

  ///Builds the article's title
  Padding _buildArticleTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        widget.article.title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  ///Build article's abstract
  Widget _buildArticleAbstract() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(widget.article.abstractText),
    );
  }

  ///Builds the article's category and date
  Padding _buildArticleCategoryAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.article.section?.toUpperCase()),
          Text(
            getStrDate(widget.article.publishedDate,
                pattern: 'MMMM yy hh:mm a'),
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
            child: (widget.article?.articleMultimedia != null &&
                    widget.article.articleMultimedia.isNotEmpty)
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
