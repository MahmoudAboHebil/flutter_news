import 'package:http/http.dart';

//'https://newsapi.org/v2/everything?q=Apple&from=2024-06-05&sortBy=popularity&apiKey=0938edb43c304fcdbec275313a280302&pageSize=20&page=1';

class ArticleService {
  final String url =
      'https://newsapi.org/v2/everything?q=Apple&from=2024-06-05&sortBy=popularity&apiKey=';
  final String urlCateArticles =
      'https://newsapi.org/v2/top-headlines?country=us';
  final String apiKey = '0938edb43c304fcdbec275313a280302';
  static const int pageSize = 20;

  Future<String> getArticles(int pageNum) async {
    String endPoint = '$url$apiKey&pageSize=$pageSize&page=$pageNum';
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode != 200) {
      throw Exception('getArticles response code is ${response.statusCode}');
    }
    return response.body;
  }

  Future<String> getCateArticles(String category) async {
    String endPoint = '$urlCateArticles&category=$category&apiKey=$apiKey';
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode != 200) {
      throw Exception('getArticles response code is ${response.statusCode}');
    }
    return response.body;
  }
}
