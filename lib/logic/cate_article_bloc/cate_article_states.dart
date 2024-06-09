import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/article_model.dart';

abstract class CateArticleState extends Equatable {}

class LoadingCateArtState extends CateArticleState {
  @override
  List<Object> get props => [];
}

class LoadedCateArtState extends CateArticleState {
  List<ArticleModel> articles;
  LoadedCateArtState({required this.articles});
  @override
  List<Object> get props => [articles];
}

class ErrorCateArtState extends CateArticleState {
  String msg;
  ErrorCateArtState({required this.msg});
  @override
  List<Object> get props => [msg];
}
