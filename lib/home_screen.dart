import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сводка новостей'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Музыка'),
            onTap: () {
              Navigator.pushNamed(context, '/music');
            },
          ),
          ListTile(
            leading: Icon(Icons.sports),
            title: Text('Спорт'),
            onTap: () {
              Navigator.pushNamed(context, '/sports');
            },
          ),
          ListTile(
            leading: Icon(Icons.health_and_safety),
            title: Text('Здоровье'),
            onTap: () {
              Navigator.pushNamed(context, '/health');
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Образование'),
            onTap: () {
              Navigator.pushNamed(context, '/education');
            },
          ),
          ListTile(
            leading: Icon(Icons.computer),
            title: Text('IT'),
            onTap: () {
              Navigator.pushNamed(context, '/it');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Избранное'),
            onTap: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
    );
  }
}
