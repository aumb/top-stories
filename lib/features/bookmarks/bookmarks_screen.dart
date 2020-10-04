import 'package:flutter/material.dart';
import 'package:top_stories/components/title_widget.dart';
import 'package:top_stories/core/core.dart';
import 'package:top_stories/features/articles/article_details_screen.dart';
import 'package:top_stories/features/bookmarks/bookmark_card.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({
    Key key,
  }) : super(key: key);

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool get hasBookmarks => BookmarkController().articles?.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildTitle(),
            hasBookmarks ? _buildArticlesGrid() : _buildNoArticles(),
          ],
        ),
      ),
    );
  }

  SliverFillRemaining _buildNoArticles() {
    return SliverFillRemaining(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Strings.noBookmarks),
        ],
      )),
    );
  }

  SliverGrid _buildArticlesGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) =>
            BookmarkCard(BookmarkController().articles[index], onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ArticleDetailsScreen(BookmarkController().articles[index]),
            ),
          );

          if (mounted) setState(() {});
        }),
        childCount: BookmarkController().articles?.length,
      ),
    );
  }

  SliverToBoxAdapter _buildTitle() {
    return SliverToBoxAdapter(
        child: TitleWidget(
      title: Strings.yourBookmarks,
    ));
  }
}
