import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/article_model.dart';

abstract class ArticleState extends Equatable {}

class LoadingArtState extends ArticleState {
  @override
  List<Object> get props => [];
}

class InitArtState extends ArticleState {
  @override
  List<Object> get props => [];
}

class LoadedArtState extends ArticleState {
  List<ArticleModel> articles;
  final bool hasReachedMax;
  final bool isFetching;
  LoadedArtState(
      {required this.articles,
      required this.hasReachedMax,
      required this.isFetching});

  LoadedArtState copyWith(
      {List<ArticleModel>? articles, bool? hasReachedMax, bool? isFetching}) {
    return LoadedArtState(
      isFetching: isFetching ?? this.isFetching,
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [articles, hasReachedMax, isFetching];
}

class ErrorArtState extends ArticleState {
  String msg;
  ErrorArtState({required this.msg});
  @override
  List<Object> get props => [msg];
}
