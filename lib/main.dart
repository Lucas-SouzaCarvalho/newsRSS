import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:news_app/assets/categories.dart';
import 'news_feed_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';


Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    auth.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notícias RSS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Categories(),
    );
  }
}
