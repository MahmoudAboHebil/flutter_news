import 'package:flutter_news/data/model/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> myCategories = [];
  late CategoryModel categorieModel;

  //1
  categorieModel = CategoryModel(
    categoryTitle: "business",
    categoryUrl:
        "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80",
  );
  myCategories.add(categorieModel);

  //2
  categorieModel = CategoryModel(
    categoryTitle: "entertainment",
    categoryUrl:
        "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
  );
  myCategories.add(categorieModel);

  //3
  categorieModel = CategoryModel(
    categoryTitle: "general",
    categoryUrl:
        "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
  );
  myCategories.add(categorieModel);

  //4
  categorieModel = CategoryModel(
    categoryTitle: "health",
    categoryUrl:
        "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80",
  );
  myCategories.add(categorieModel);

  //5
  categorieModel = CategoryModel(
    categoryTitle: "science",
    categoryUrl:
        "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80",
  );
  myCategories.add(categorieModel);

  //6
  categorieModel = CategoryModel(
    categoryTitle: "sports",
    categoryUrl:
        "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80",
  );
  myCategories.add(categorieModel);

  //7
  categorieModel = CategoryModel(
    categoryTitle: "technology",
    categoryUrl:
        "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
  );
  myCategories.add(categorieModel);

  return myCategories;
}
