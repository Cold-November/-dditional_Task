import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_explorer/news.dart';
import 'package:news_explorer/new_detail_screen.dart';
import 'package:hive/hive.dart';

class HealthScreen extends StatelessWidget {
  final List<News> healthNews = [
    News(
      title: '"Продолжительная и активная жизнь"',
      description: 'Мурашко рассказал о новом нацпроекте "Продолжительная и активная жизнь"',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyDM_gTjN4bkiPCLHIGEs2EZUSaXBlHG9Kyg&s',
      content: 'Минздрав планирует опережающими темпами снижать показатели по смертности и повышать доверие граждан к системе здравоохранения, для этого с 2025 года будет запущен новый национальный проект "Продолжительная и активная жизнь", заявил РИА Новости министр здравоохранения России Михаил Мурашко.',
    ),
    News(
      title: 'Белоусов провел совещание по вопросам медобеспечения участников СВО',
      description: 'Белоусов обсудил с Мурашко вопросы реабилитации и протезирования военнослужащих',
      imageUrl: 'https://img.gazeta.ru/files3/755/11891755/RIAN_3076749.HR-pic_32ratio_1200x800-1200x800-5412.jpg',
      content: 'Глава Минобороны РФ Андрей Белоусов провел совещание по вопросам медицинского обеспечения участников спецоперации, на нем также обсуждались вопросы проведения реабилитации и протезирования, сообщили в министерстве.',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Здоровье'),
      ),
      body: ListView.builder(
        itemCount: healthNews.length,
        itemBuilder: (context, index) {
          final news = healthNews[index];
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
