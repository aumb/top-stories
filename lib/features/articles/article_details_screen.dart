import 'package:flutter/material.dart';
import 'package:top_stories/components/custom_cached_network_image.dart';
import 'package:top_stories/components/custom_list_tile.dart';
import 'package:top_stories/components/image_placeholder_widget.dart';
import 'package:top_stories/components/section_date_widget.dart';
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
  ///Used to call snackbar
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

  bool get isBookmarked => _controller.isBookmarked();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _controller.refreshStream,
        builder: (context, snapshot) {
          return Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              child: CustomScrollView(
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
                    child: SectionAndDateWidget(article: widget.article),
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
            ),
          );
        });
  }

  Widget _buildBookmark() {
    return CustomListTile(
      icon: Icons.bookmark,
      iconColor: isBookmarked ? Color.fromRGBO(237, 155, 0, 1) : null,
      title: isBookmarked ? Strings.removeBookmark : Strings.bookmark,
      onTap: () async => await toggleBookmark(),
    );
  }

  ///Builds a snackbar depending on the state of the bookmarking.
  SnackBar _buildSnackBar() {
    if (BookmarkController().pageState == PageState.error) {
      return SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(Strings.bookmarkError),
        action: SnackBarAction(
          label: Strings.retry,
          onPressed: () async => await toggleBookmark(),
        ),
      );
    } else {
      return SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
            !isBookmarked ? Strings.removedBookmark : Strings.addedToBookmarks),
        action: SnackBarAction(
          label: Strings.undo,
          onPressed: () async => await toggleBookmark(),
        ),
      );
    }
  }

  Widget _buildGoToArticle() {
    return CustomListTile(
      icon: Icons.web,
      title: Strings.fullArticle,
      onTap: () => launchUrls(scheme: 'https', path: widget.article.url),
    );
  }

  Padding _buildArticleTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        widget.article.title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildArticleAbstract() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(widget.article.abstractText),
    );
  }

  Row _buildImage() {
    return Row(
      children: [
        Expanded(
          child: Hero(
            tag: 'article_picture_${widget.article.url}',
            child: (widget.article?.articleMultimedia != null &&
                    widget.article.articleMultimedia.isNotEmpty)
                ? CustomCachedNetworkImage(getimageUrl(widget.article))
                : ImagePlaceholderWidget(),
          ),
        ),
      ],
    );
  }

  ///If the bookmarking succeeds. A success snackbar is displayed with the option to undo
  ///if it does not succeed an snackbar is displayed with an option to retry
  toggleBookmark() async {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    isBookmarked
        ? await BookmarkController().removeBookmarkedArticle(widget.article)
        : await BookmarkController().bookmarkArticle(widget.article);

    final SnackBar snackBar = _buildSnackBar();
    _scaffoldKey.currentState.showSnackBar(snackBar);
    _controller.refresh = true;
  }
}
