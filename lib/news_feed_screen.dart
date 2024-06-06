import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'news_item.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  List<RssItem>? _newsItems;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(
        Uri.parse('https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml'));
    if (response.statusCode == 200) {
      final RssFeed feed = RssFeed.parse(response.body);
      setState(() {
        _newsItems = feed.items;
      });
    } else {
      throw Exception('Falha ao carregar o feed RSS');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: _newsItems == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _newsItems!.length,
              itemBuilder: (context, index) {
                FirebaseAnalytics.instance.logViewItem(
                  items: <AnalyticsEventItem>[
                    AnalyticsEventItem(itemCategory: _newsItems!.elementAt(index).categories!.first.value)
                  ]
                );
                final item = _newsItems![index];
                return NewsItem(item: item);
              },
            ),
    );
  }
}
