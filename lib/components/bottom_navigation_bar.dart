import 'package:flutter/material.dart';
import 'package:top_stories/core/core.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int value) onTap;

  CustomBottomNavigationBar({
    this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          title: Text(Strings.articles),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          title: Text(Strings.bookmarks),
        ),
      ],
    );
  }
}
