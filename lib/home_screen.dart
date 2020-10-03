import 'package:flutter/material.dart';
import 'package:top_stories/core/core.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Network().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
