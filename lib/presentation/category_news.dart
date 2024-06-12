import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/logic/cate_article_bloc/cate_article_bloc.dart';
import 'package:flutter_news/logic/cate_article_bloc/cate_article_events.dart';

import '../logic/cate_article_bloc/cate_article_states.dart';
import 'components/blog_tile.dart';

class CategoryNews extends StatefulWidget {
  final String cateName;
  const CategoryNews({super.key, required this.cateName});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 300) {
      context
          .read<CateArticleBloc>()
          .add(LoadCateArtsEvent(cateName: widget.cateName));
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.add),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
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
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: state.articles.length,
                            itemBuilder: (context, index) {
                              if (state.articles[index].author != null &&
                                  state.articles[index].urlToImage != null) {
                                return BlogTile(
                                  title: state.articles[index].title!,
                                  imageUrl: state.articles[index].urlToImage!,
                                  desc: state.articles[index].description!,
                                  blocUrl: state.articles[index].url!,
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          state.isFetching
                              ? Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 40),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Container(),
                          state.hasReachedMax
                              ? Container(
                                  padding: EdgeInsets.only(top: 30, bottom: 40),
                                  color: Colors.amber,
                                  child: Center(
                                    child: Text(
                                        'You have fetched all of the content'),
                                  ),
                                )
                              : Container()
                        ],
                      );
                    } else if (state is ErrorCateArtState) {
                      return Center(
                        child: Text(
                          'Ops!, There is an Error',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2),
                        child: CircularProgressIndicator(),
                      ),
                    );
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
