import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/logic/article_bloc/article_bloc.dart';
import 'package:flutter_news/logic/article_bloc/article_states.dart';

import '../data/helper/data.dart';
import '../data/model/category_model.dart';
import '../logic/article_bloc/article_events.dart';
import 'components/blog_tile.dart';
import 'components/category_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categoryData = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    categoryData = getCategories();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // if (_scrollController.position.pixels ==
    //     _scrollController.position.maxScrollExtent) {
    //   context.read<ArticleBloc>().add(LoadArtsEvent());
    // }
    if (_scrollController.position.extentAfter < 300) {
      print('objectobject');
      context.read<ArticleBloc>().add(LoadArtsEvent());
    }
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
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              //category
              Container(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categoryData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      title: categoryData[index].categoryTitle,
                      imageUrl: categoryData[index].categoryUrl,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 26,
              ),
              //blog
              Container(
                child: BlocBuilder(
                  bloc: BlocProvider.of<ArticleBloc>(context),
                  builder: (context, state) {
                    if (state is LoadedArtState) {
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: state.articles.length,
                            // .where((e) => e['author'] != null && e['urlToImage'] != null)
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
                    } else if (state is ErrorArtState) {
                      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
                      print(state.msg);
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
