import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_explorer/news.dart';
import 'package:news_explorer/new_detail_screen.dart';
import 'package:hive/hive.dart';

class EducationScreen extends StatelessWidget {
  final List<News> educationNews = [
    News(
      title: 'Кравцов рассказал о системе образования в России',
      description: 'Кравцов: система образования выстроена так, чтобы работать в интересах детей',
      imageUrl: 'https://s.ura.news/760/images/news/upload/news/660/226/1052660226/777691_Festivaly_Bilet_v_budushtee_Ekaterinburg_kravtsov_sergey_250x0_1270.849.0.0.jpg',
      content: 'Система образования в России выстроена таким образом, чтобы работать в интересах школьников, родителей планируется активно вовлекать в воспитательный процесс, заявил кандидат на пост министра просвещения РФ Сергей Кравцов.',
    ),
    News(
      title: 'Белоусов заявил о проблемах в сфере военного образования',
      description: 'Белоусов: прежде всего надо заниматься военным образованием, здесь есть проблемы',
      imageUrl: 'https://img.gazeta.ru/files3/755/11891755/RIAN_3076749.HR-pic_32ratio_1200x800-1200x800-5412.jpg',
      content: 'В первоочередном порядке нужно заниматься военным образованием, здесь накоплены определенные проблемы, заявил кандидат на пост министра обороны РФ Андрей Белоусов.',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Образование'),
      ),
      body: ListView.builder(
        itemCount: educationNews.length,
        itemBuilder: (context, index) {
          final news = educationNews[index];
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
