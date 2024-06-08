import 'package:http/http.dart';

class ArticleService {
  final String url =
      'https://newsapi.org/v2/everything?q=Apple&from=2024-06-05&sortBy=popularity&apiKey=';
  final String apiKey = '0938edb43c304fcdbec275313a280302';
  Future<String> getArticles() async {
    String endPoint = url + apiKey;
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode != 200) {
      throw Exception('getArticles response code is ${response.statusCode}');
    }
    return response.body;
  }
}
