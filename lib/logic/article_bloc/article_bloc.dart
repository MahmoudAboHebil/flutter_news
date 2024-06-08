import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/data/model/article_model.dart';
import 'package:flutter_news/logic/article_bloc/article_events.dart';
import 'package:flutter_news/logic/article_bloc/article_states.dart';

import '../../data/repository/article_repo.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepo articleRepo;
  ArticleBloc({required this.articleRepo}) : super(LoadingArtState()) {
    on<LoadArtsEvent>((event, emit) async {
      emit(LoadingArtState());
      try {
        List<ArticleModel> articles = await articleRepo.getArticles();

        emit(LoadedArtState(articles: articles));
      } catch (e) {
        emit(ErrorArtState(msg: e.toString()));
      }
    });
  }
  @override
  void onChange(Change<ArticleState> change) {
    super.onChange(change);
    print(change.toString());
  }
}
