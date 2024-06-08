import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/data/repository/article_repo.dart';
import 'package:flutter_news/logic/article_bloc/article_bloc.dart';
import 'package:flutter_news/logic/article_bloc/article_events.dart';
import 'package:flutter_news/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ArticleRepo>(
      create: (context) => ArticleRepo(),
      child: BlocProvider<ArticleBloc>(
        create: (context) => ArticleBloc(
            articleRepo: RepositoryProvider.of<ArticleRepo>(context))
          ..add(LoadArtsEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
