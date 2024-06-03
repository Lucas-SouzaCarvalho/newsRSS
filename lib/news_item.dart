import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:webfeed/webfeed.dart';

class NewsItem extends StatelessWidget {
  final RssItem item;

  const NewsItem({required this.item});

  void _openNews(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir a URL: $url';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }
    return DateFormat.yMMMd().format(date);
  }

  String? _getImageUrl(RssItem item) {
    if (item.media != null &&
        item.media!.contents != null &&
        item.media!.contents!.isNotEmpty) {
      for (var content in item.media!.contents!) {
        if (content.url != null) {
          return content.url!;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_getImageUrl(item) != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  _getImageUrl(item)!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    _formatDate(item.pubDate),
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    item.description ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        _openNews(item.link ?? '');
                      },
                      child: Text('Read more'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
