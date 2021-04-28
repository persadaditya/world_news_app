
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:world_news_app/helper/Config.dart';
import 'package:world_news_app/model/Headline.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  late Future<Headline> futureHeadline;
  String date = "";

  @override
  void initState() {
    super.initState();
    futureHeadline = fetchHeadline();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text("Headline",
                style: TextStyle(color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                textAlign: TextAlign.start,

              ),
            ),
            Container(
              height: 450,
              child: FutureBuilder<Headline>(
                future: futureHeadline,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index){
                          String dates = snapshot.data!.articles![index].publishedAt!;
                          List<String> date = dates.split("T");
                          print("urlImage: ${snapshot.data!.articles![index].urlToImage}");
                          return Container(
                            width: 300,
                            height: 400,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.blueAccent),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: snapshot.data!.articles![index].urlToImage!,
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          ),
                                      borderRadius: BorderRadius.circular(10)
                                      ),
                                  ),
                                  placeholder: (context, url) => Image.network("https://img.freepik.com/free-vector/news-concept-landing-page_52683-20522.jpg?size=626&ext=jpg"),
                                  errorWidget: (context, url, error) => Icon(Icons.report_gmailerrorred_rounded),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data!.articles![index].title!,
                                        style: TextStyle(fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                      Text(date[0])
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else if(snapshot.hasError){
                    return Text("${snapshot.error} | ${snapshot.stackTrace.toString()}");
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}



