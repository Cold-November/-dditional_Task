import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('favorites');
  }

  void addFavorite(Map<String, dynamic> news) {
    final box = Hive.box('favorites');
    box.add(news);
  }

  void removeFavorite(int index) {
    final box = Hive.box('favorites');
    box.deleteAt(index);
  }
}
