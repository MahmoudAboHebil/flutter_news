import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/article_model.dart';

abstract class ArticleState extends Equatable {}

class LoadingArtState extends ArticleState {
  @override
  List<Object> get props => [];
}

class LoadedArtState extends ArticleState {
  List<ArticleModel> articles;
  LoadedArtState({required this.articles});
  @override
  List<Object> get props => [articles];
}

class ErrorArtState extends ArticleState {
  String msg;
  ErrorArtState({required this.msg});
  @override
  List<Object> get props => [msg];
}
