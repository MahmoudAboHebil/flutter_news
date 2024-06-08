import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {}

class LoadArtsEvent extends ArticleEvent {
  @override
  List<Object> get props => [];
}
