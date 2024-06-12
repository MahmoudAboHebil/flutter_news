import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/data/model/article_model.dart';
import 'package:flutter_news/data/service/article_service.dart';

import '../../data/repository/article_repo.dart';
import 'cate_article_events.dart';
import 'cate_article_states.dart';

class CateArticleBloc extends Bloc<CateArticleEvent, CateArticleState> {
  final ArticleRepo articleRepo;
  int pageNum = 1;
  CateArticleBloc({required this.articleRepo}) : super(InitCateArtState()) {
    on<LoadCateArtsEvent>((event, emit) async {
      final currentState = state;
      try {
        if (!_isHasReachedMax(currentState)) {
          if (currentState is InitCateArtState) {
            List<ArticleModel> list =
                await articleRepo.getCateArticles(event.cateName, pageNum);
            if (list.isEmpty) {}
            emit(LoadedCateArtState(
                articles: list,
                hasReachedMax: list.length < ArticleService.pageSize,
                isFetching: false));
            pageNum++;
          } else if (currentState is LoadedCateArtState) {
            emit(currentState.copyWith(isFetching: true));
            await Future.delayed(Duration(seconds: 1));
            List<ArticleModel> list =
                await articleRepo.getCateArticles(event.cateName, pageNum);
            emit(list.isEmpty
                ? currentState.copyWith(hasReachedMax: true, isFetching: false)
                : LoadedCateArtState(
                    articles: list + currentState.articles,
                    hasReachedMax: list.length < ArticleService.pageSize,
                    isFetching: false,
                  ));
            pageNum++;
          }
        }
      } catch (e) {
        if (e.toString().contains('response code is 426')) {
          if (currentState is LoadedCateArtState) {
            emit(currentState.copyWith(isFetching: false, hasReachedMax: true));
          } else {
            emit(ErrorCateArtState(msg: e.toString()));
          }
        } else {
          emit(ErrorCateArtState(msg: e.toString()));
        }
      }
    });
  }
  bool _isHasReachedMax(CateArticleState state) =>
      state is LoadedCateArtState && state.hasReachedMax;
  @override
  void onChange(Change<CateArticleState> change) {
    super.onChange(change);
    print(change.toString());
  }
}
