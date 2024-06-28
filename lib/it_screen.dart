import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_explorer/news.dart';
import 'package:news_explorer/new_detail_screen.dart';
import 'package:hive/hive.dart';

class ITScreen extends StatelessWidget {
  final List<News> itNews = [
    News(
      title: 'Исследователи назвали долю россиян, допускающих восстание машин',
      description: 'ВШЭ и «Ромир»: внедрение IT в повседневную жизнь беспокоит 25% россиян',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ70oex5qCVoxAP40_Mt3TfAnZLcRlp3IdKHA&s',
      content: 'В Сети по теме IT россияне чаще всего обсуждают вытеснение их из профессии роботами, но упоминают и риски потери контроля над искусственным интеллектом и восстание машин',
    ),
    News(
      title: 'Белоусов спрогнозировал переворот в технологиях связи и навигации в ближайшие годы',
      description: 'По словам первого вице-премьера РФ, созданием и эксплуатацией низкоорбитальной группировки спутников в могут заниматься четыре страны',
      imageUrl: 'https://img.gazeta.ru/files3/755/11891755/RIAN_3076749.HR-pic_32ratio_1200x800-1200x800-5412.jpg',
      content: ' Развитие группировки низкоорбитальных спутников через несколько лет приведет к технологическому перевороту в сфере широкополосного интернета, навигации и сверхскоростной связи, заявил на форуме "Открытые инновации" первый вице-премьер РФ Андрей Белоусов.',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IT'),
      ),
      body: ListView.builder(
        itemCount: itNews.length,
        itemBuilder: (context, index) {
          final news = itNews[index];
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
