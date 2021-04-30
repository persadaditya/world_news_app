
import 'package:world_news_app/helper/Config.dart';
import 'package:world_news_app/model/Headline.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HeadlineRepo{

  Future<Headline> fetchHeadline() async {
    var buildUriHttps = Uri.https(Config.baseUrl, Config.topHeadline, Config.queryHeadline());
    final response = await http.get(buildUriHttps);
    print("url Headline: ${buildUriHttps.toString()}");

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return Headline.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load headline');
    }
  }

  Future<Headline> fetchHeadlineByCategory(String category) async {
    var buildUriHttps = Uri.https(Config.baseUrl, Config.topHeadline, Config.queryCategoryHeadline(category));
    final response = await http.get(buildUriHttps);
    print('url category: ${buildUriHttps.toString()}');

    if(response.statusCode==200){
      print('response ${response.body.toString()}');
      return Headline.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load category');
    }
  }
}