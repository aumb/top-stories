import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildTitle(),
            _buildArticlesGrid(),
          ],
        ),
      ),
    );
  }

  ///Builds the bookmarked articles grid
  SliverGrid _buildArticlesGrid() {
    return SliverGrid(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) =>
            BookmarkCard(BookmarkController().articles[index], onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ArticleDetailsScreen(BookmarkController().articles[index]),
            ),
          );
          setState(() {});
        }),
        childCount: BookmarkController().articles?.length,
      ),
    );
  }

  ///Build the title at the top of the articles page
  SliverPadding _buildTitle() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          Strings.yourBookmarks,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
