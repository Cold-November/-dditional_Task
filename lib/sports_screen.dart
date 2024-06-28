import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_explorer/news.dart';
import 'package:news_explorer/new_detail_screen.dart';
import 'package:hive/hive.dart';

class SportsScreen extends StatelessWidget {
  final List<News> sportNews = [
    News(
      title: 'Олимпийские игры в Париже',
      description: 'Наши дзюдоисты не примут участия в олимпиаде',
      imageUrl: 'https://img.gazeta.ru/files3/641/12185641/upload-RIAN_5782404.HR-pic905-895x505-83580.jpg',
      content: '«Российские дзюдоисты не примут участие в Олимпийских играх в Париже» — Соловейчик',
    ),
    News(
      title: 'ГАНДБОЛ',
      description: 'Удар под дых русофобам. Звезду из России признали лучшей в Лиге чемпионов',
      imageUrl: 'https://avatars.dzeninfra.ru/get-zen_doc/1711960/pub_5ce189e900ad2100b393a792_5ce18f080d473000b08afd9b/scale_1200',
      content: 'Международные федерации не считают чем-то зазорным обделять и откровенно дискриминировать спортсменов из России.',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Спорт'),
      ),
      body: ListView.builder(
        itemCount: sportNews.length,
        itemBuilder: (context, index) {
          final news = sportNews[index];
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: news.imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(news.title),
            subtitle: Text(news.description),
            trailing: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                // Добавление новости в избранное
                addToFavorites(news);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Добавлено в избранное'),
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
      ),
    );
  }

  void addToFavorites(News news) {
    final box = Hive.box('favorites');
    box.add({
      'title': news.title,
      'description': news.description,
      'imageUrl': news.imageUrl,
      'content': news.content,
    });
  }
}
