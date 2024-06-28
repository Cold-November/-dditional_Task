import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_explorer/news.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  NewsDetailScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: news.imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text(
                news.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                news.content,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
