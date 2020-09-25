import 'package:flutter/cupertino.dart';
import 'package:nepnews/models/news_model.dart';

class BookmarkBloc extends ChangeNotifier {
  int _count = 0;
  List<News> news = [];

  void addCount() {
    _count++;
    notifyListeners();
  }

  void addNews(News data) {
    news.add(data);
    notifyListeners();
  }

  int get count {
    return _count;
  }

  List<News> get NewsList {
    return news;
  }
}