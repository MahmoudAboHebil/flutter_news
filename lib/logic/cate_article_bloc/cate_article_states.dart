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
  LoadedCateArtState(
      {required this.articles,
      required this.hasReachedMax,
      required this.isFetching});
  LoadedCateArtState copyWith(
      {List<ArticleModel>? articles, bool? hasReachedMax, bool? isFetching}) {
    return LoadedCateArtState(
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [articles, hasReachedMax, isFetching];
}

class ErrorCateArtState extends CateArticleState {
  String msg;
  ErrorCateArtState({required this.msg});
  @override
  List<Object> get props => [msg];
}
