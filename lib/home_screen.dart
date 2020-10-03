import 'package:flutter/material.dart';
import 'package:top_stories/core/core.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ArticlesController _controller;

  @override
  void initState() {
    super.initState();
    Network().init();
    _controller = ArticlesController();
    _controller.getArticles();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _controller.combinedStream,
        builder: (context, snapshot) {
          return Scaffold();
        });
  }
}
