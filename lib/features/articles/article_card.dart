import 'package:flutter/material.dart';
import 'package:top_stories/components/custom_cached_network_image.dart';
import 'package:top_stories/components/image_placeholder_widget.dart';
import 'package:top_stories/components/section_date_widget.dart';
import 'package:top_stories/core/core.dart';
import 'package:top_stories/features/articles/article_details_screen.dart';

class ArticleCard extends StatefulWidget {
  final Article article;

  ArticleCard(this.article);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
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
          return InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    ArticleDetailsScreen(widget.article),
              ),
            ),
            child: Card(
              child: Column(
                children: [
                  _buildImage(),
                  SectionAndDateWidget(article: widget.article),
                  if (isNotEmpty(widget.article.title))
                    _buildArticleTitle(context),
                  if (isNotEmpty(widget.article.title)) SizedBox(height: 16),
                  _buildBookmark(),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildBookmark() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () async => await toggleBookmark(),
            icon: Icon(
              Icons.bookmark,
              color: isBookmarked ? Color.fromRGBO(237, 155, 0, 1) : null,
            ),
          ),
          IconButton(
            onPressed: () =>
                launchUrls(scheme: 'https', path: widget.article.url),
            icon: Icon(
              Icons.web,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildArticleTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        widget.article.title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Row _buildImage() {
    return Row(
      children: [
        Expanded(
          child: Hero(
            tag: 'article_picture_${widget.article.url}',
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              child: (widget.article?.articleMultimedia != null &&
                      widget.article.articleMultimedia.isNotEmpty)
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child:
                          CustomCachedNetworkImage(getimageUrl(widget.article)),
                    )
                  : AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ImagePlaceholderWidget(),
                    ),
            ),
          ),
        ),
      ],
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

  ///If the bookmarking succeeds. A success snackbar is displayed with the option to undo
  ///if it does not succeed an snackbar is displayed with an option to retry
  toggleBookmark() async {
    Scaffold.of(context).hideCurrentSnackBar();
    isBookmarked
        ? await BookmarkController().removeBookmarkedArticle(widget.article)
        : await BookmarkController().bookmarkArticle(widget.article);

    final SnackBar snackBar = _buildSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
    _controller.refresh = true;
  }
}
