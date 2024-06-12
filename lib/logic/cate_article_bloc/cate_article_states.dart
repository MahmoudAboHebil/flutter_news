import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/article_model.dart';

abstract class CateArticleState extends Equatable {}

class InitCateArtState extends CateArticleState {
  @override
  List<Object> get props => [];
}

class LoadedCateArtState extends CateArticleState {
  final List<ArticleModel> articles;
  final bool hasReachedMax;
  final bool isFetching;
  final String cateTitle;
  LoadedCateArtState({
    required this.articles,
    required this.hasReachedMax,
    required this.isFetching,
    required this.cateTitle,
  });
  LoadedCateArtState copyWith(
      {List<ArticleModel>? articles,
      bool? hasReachedMax,
      bool? isFetching,
      String? cateTitle}) {
    return LoadedCateArtState(
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetching: isFetching ?? this.isFetching,
      cateTitle: cateTitle ?? this.cateTitle,
    );
  }

  @override
  List<Object> get props => [articles, hasReachedMax, isFetching, cateTitle];
}

class ErrorCateArtState extends CateArticleState {
  String msg;
  ErrorCateArtState({required this.msg});
  @override
  List<Object> get props => [msg];
}
