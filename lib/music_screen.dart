import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_explorer/news.dart';
import 'package:news_explorer/new_detail_screen.dart';
import 'package:hive/hive.dart';

class MusicScreen extends StatelessWidget {
  final List<News> musicNews = [
    News(
      title: 'Релизы альбомов 2024',
      description: 'Топ-альбомов на июнь 2024',
      imageUrl: 'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_6599b27fafd8fd1141527a8b_6599b28aafd8fd1141527bbe/scale_1200',
      content: 'Топ 5 рок-альбомов на 2024:\n'
          'Green Day — «Saviors»\n'
          'Alkaline Trio — «Blood, Hair и Eyeballs»\n'
          'Static-X — «Regeneration Vol. 2»\n'
          'Judas Priest — «Invincible Shield»\n'
          'The Black Crowes — «Happiness Bastards»\n',
    ),
    News(
      title: 'Шаман: О пути успеха',
      description: 'История простого русского паренька.',
      imageUrl: 'https://cdnn21.img.ria.ru/images/07e8/05/07/1944333388_0:320:3072:2048_1920x0_80_0_0_9163d22c3f4aa07bc2de1c57260f4cb5.jpg',
      content: '"Я русский и я иду до конца" - Шаман о том, как получал ипотеку в 2023 году у застройщика жк "Лучи"',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Музыка'),
      ),
      body: ListView.builder(
        itemCount: musicNews.length,
        itemBuilder: (context, index) {
          final news = musicNews[index];
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
