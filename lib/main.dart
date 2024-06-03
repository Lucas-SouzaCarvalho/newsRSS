import 'package:flutter/material.dart';
import 'news_feed_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notícias RSS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsFeedScreen(),
    );
  }
}
