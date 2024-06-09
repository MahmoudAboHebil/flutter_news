import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/logic/cate_article_bloc/cate_article_bloc.dart';
import 'package:flutter_news/logic/cate_article_bloc/cate_article_events.dart';
import 'package:flutter_news/presentation/category_news.dart';

class CategoryTile extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CategoryTile({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<CateArticleBloc>(context)
            .add(LoadCateArtsEvent(cateName: title.toLowerCase()));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryNews(),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(6)),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
