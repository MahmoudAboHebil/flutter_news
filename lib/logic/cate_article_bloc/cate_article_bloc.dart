import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/data/model/article_model.dart';

import '../../data/repository/article_repo.dart';
import 'cate_article_events.dart';
import 'cate_article_states.dart';

class CateArticleBloc extends Bloc<CateArticleEvent, CateArticleState> {
  final ArticleRepo articleRepo;
  CateArticleBloc({required this.articleRepo}) : super(LoadingCateArtState()) {
    on<LoadCateArtsEvent>((event, emit) async {
      emit(LoadingCateArtState());
      try {
        List<ArticleModel> articles =
            await articleRepo.getCateArticles(event.cateName);

        emit(LoadedCateArtState(articles: articles));
      } catch (e) {
        emit(ErrorCateArtState(msg: e.toString()));
      }
    });
  }
  @override
  void onChange(Change<CateArticleState> change) {
    super.onChange(change);
    print(change.toString());
  }
}
