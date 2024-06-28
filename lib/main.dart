import 'package:flutter/material.dart';
import 'package:news_explorer/hive_service.dart';
import 'package:news_explorer/home_screen.dart';
import 'package:news_explorer/music_screen.dart';
import 'package:news_explorer/sports_screen.dart';
import 'package:news_explorer/health_screen.dart';
import 'package:news_explorer/education_screen.dart';
import 'package:news_explorer/it_screen.dart';
import 'package:news_explorer/favorites_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  runApp(NewsExplorerApp());
}


class NewsExplorerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/music': (context) => MusicScreen(),
        '/sports': (context) => SportsScreen(),
        '/health': (context) => HealthScreen(),
        '/education': (context) => EducationScreen(),
        '/it': (context) => ITScreen(),
        '/favorites': (context) => FavoritesScreen(),
      },
    );
  }
}
