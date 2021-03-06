import 'package:flutter/material.dart';
import 'package:top_stories/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline4: TextStyle(
            color: Colors.black87,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
