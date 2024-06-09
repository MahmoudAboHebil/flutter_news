import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/logic/article_bloc/article_bloc.dart';
import 'package:flutter_news/logic/article_bloc/article_states.dart';

import '../data/helper/data.dart';
import '../data/model/category_model.dart';
import 'components/blog_tile.dart';
import 'components/category_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categoryData = [];
  @override
  void initState() {
    super.initState();
    categoryData = getCategories();
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
                    } else if (state is ErrorArtState) {
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