import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/data/model/article_model.dart';
import 'package:flutter_news/data/service/article_service.dart';
import 'package:flutter_news/logic/article_bloc/article_events.dart';
import 'package:flutter_news/logic/article_bloc/article_states.dart';

import '../../data/repository/article_repo.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepo articleRepo;
  int page = 1;
  ArticleBloc({required this.articleRepo}) : super(InitArtState()) {
    on<LoadArtsEvent>((event, emit) async {
      final currentState = state;
      try {
        if (!_hasReachedMax(currentState)) {
          if (currentState is InitArtState) {
            List<ArticleModel> articles = await articleRepo.getArticles(page);
            emit(LoadedArtState(
                articles: articles,
                hasReachedMax: articles.length < ArticleService.pageSize,
                isFetching: false));
            page++;
          } else if (currentState is LoadedArtState) {
            emit(currentState.copyWith(isFetching: true));
            await Future.delayed(Duration(seconds: 2));
            List<ArticleModel> articles = await articleRepo.getArticles(page);

            emit(articles.isEmpty
                ? currentState.copyWith(hasReachedMax: true)
                : LoadedArtState(
                    articles: articles + currentState.articles,
                    hasReachedMax: articles.length < ArticleService.pageSize,
                    isFetching: false));
            page++;
          }
        } else {}
      } catch (e) {
        if (e.toString().contains('response code is 426')) {
          if (currentState is LoadedArtState) {
            emit(currentState.copyWith(isFetching: false, hasReachedMax: true));
          } else {
            emit(ErrorArtState(msg: e.toString()));
          }
        } else {
          emit(ErrorArtState(msg: e.toString()));
        }
      }
    });
  }
  bool _hasReachedMax(ArticleState state) =>
      state is LoadedArtState && state.hasReachedMax;

  @override
  void onChange(Change<ArticleState> change) {
    super.onChange(change);
    print(change.toString());
  }
}
