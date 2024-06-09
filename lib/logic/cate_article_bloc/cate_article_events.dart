import 'package:equatable/equatable.dart';

abstract class CateArticleEvent extends Equatable {}

class LoadCateArtsEvent extends CateArticleEvent {
  final String cateName;
  LoadCateArtsEvent({required this.cateName});
  @override
  List<Object> get props => [cateName];
}
