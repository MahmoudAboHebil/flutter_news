import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/logic/cate_article_bloc/cate_article_bloc.dart';

import '../logic/cate_article_bloc/cate_article_states.dart';
import 'components/blog_tile.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({super.key});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter'),
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              //blog
              Container(
                child: BlocBuilder(
                  bloc: BlocProvider.of<CateArticleBloc>(context),
                  builder: (context, state) {
                    if (state is LoadedCateArtState) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: state.articles.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                              title: state.articles[index].title!,
                              imageUrl: state.articles[index].urlToImage!,
                              desc: state.articles[index].description!);
                        },
                      );
                    } else if (state is ErrorCateArtState) {
                      return Center(
                        child: Text(
                          'Ops!, There is an Error',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
