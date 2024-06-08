import 'dart:convert';

import 'package:flutter_news/data/service/article_service.dart';

import '../model/article_model.dart';

class ArticleRepo {
  final ArticleService artService = ArticleService();

  Future<List<ArticleModel>> getArticles() async {
    try {
      final response = await artService.getArticles();
      final List result = jsonDecode(response)['articles'];
      List<ArticleModel> arts = result
          .where((e) => e['author'] != null && e['urlToImage'] != null)
          .map((e) {
        return ArticleModel.fromJson(e);
      }).toList();

      return arts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
