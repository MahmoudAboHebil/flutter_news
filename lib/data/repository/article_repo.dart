import 'dart:convert';

import 'package:flutter_news/data/service/article_service.dart';

import '../model/article_model.dart';

class ArticleRepo {
  final ArticleService artService = ArticleService();

  Future<List<ArticleModel>> getArticles(int pageNum, int? tempSize) async {
    try {
      final response = await artService.getArticles(pageNum, tempSize);
      final List result = jsonDecode(response)['articles'];
      List<ArticleModel> arts = result.map((e) {
        return ArticleModel.fromJson(e);
      }).toList();

      return arts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ArticleModel>> getCateArticles(
    String category,
    int pageNumber,
  ) async {
    try {
      final response = await artService.getCateArticles(category, pageNumber);
      final List result = jsonDecode(response)['articles'];
      List<ArticleModel> arts = result.map((e) {
        return ArticleModel.fromJson(e);
      }).toList();

      return arts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
