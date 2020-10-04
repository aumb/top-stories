import 'package:flutter/material.dart';
import 'package:top_stories/components/bottom_navigation_bar.dart';
import 'package:top_stories/core/core.dart';
import 'package:top_stories/features/articles/articles_screen.dart';
import 'package:top_stories/features/bookmarks/bookmarks_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController _controller;
  List<Widget> _bottomNavigationItems = [
    ArticlesScreen(),
    BookmarksScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Network().init();
    BookmarkController().getBookmarkedArticles();
    _controller = HomeController();
  }

  @override
  void dispose() {
    _controller.dispose();
    BookmarkController().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _controller.currentIndexStream,
        builder: (context, snapshot) {
          return StreamBuilder<List<Article>>(
              stream: BookmarkController().articlesStream,
              builder: (context, snapshot) {
                return Scaffold(
                  bottomNavigationBar: _buildBottomNavigationBar(),
                  body: _bottomNavigationItems[_controller.currentIndex],
                );
              });
        });
  }

  CustomBottomNavigationBar _buildBottomNavigationBar() {
    return CustomBottomNavigationBar(
      currentIndex: _controller.currentIndex,
      onTap: (index) {
        _controller.currentIndex = index;
      },
    );
  }
}
