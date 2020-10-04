import 'package:flutter/material.dart';
import 'package:top_stories/core/core.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  ///The current page selected
  final int currentIndex;

  ///Action on the tap of a tab bar item
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
          icon: Icon(Icons.bookmark),
          title: Text(Strings.bookmarks),
        ),
      ],
    );
  }
}
