import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_explorer/news.dart';
import 'package:news_explorer/new_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('favorites').listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return Center(child: Text('Нет "избранных" новостей'));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final newsData = box.getAt(index) as Map;
                final news = News(
                  title: newsData['title'],
                  description: newsData['description'],
                  imageUrl: newsData['imageUrl'],
                  content: newsData['content'],
                );
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: news.imageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(news.title),
                  subtitle: Text(news.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Удаление новости из избранного
                      box.deleteAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Удалено из избранного'),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    // Переход на экран деталей новости
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(news: news),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
