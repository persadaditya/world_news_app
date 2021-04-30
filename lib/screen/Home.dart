
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:world_news_app/model/Headline.dart';
import 'package:world_news_app/repository/HeadlineRepo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Future<Headline> futureHeadline;
  String date = "";
  List<String> category = List<String>.empty(growable: true);
  int? indexCategory = 0;
  late Future<Headline> futureHeadlineCategory;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    futureHeadline = HeadlineRepo().fetchHeadline();

    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {
        indexCategory = _tabController.index;
      });
    });

    category.add("Business");
    category.add("Entertainment");
    category.add("Health");
    category.add("Science");
    category.add("Sports");
    category.add("Technology");

    futureHeadlineCategory = HeadlineRepo().fetchHeadlineByCategory(category[0]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return [
            SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  centerTitle: false,
                  title: Text('Headline',
                    style: TextStyle(color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),),
                  backgroundColor: Colors.white,
                  expandedHeight: 500,
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                      background: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 48),
                          child: Container(
                            height: 440,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: FutureBuilder<Headline>(
                              future: futureHeadline,
                              builder: (context, snapshot){
                                if(snapshot.hasData){
                                  return SizedBox(
                                    height: 440,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.articles!.length,
                                        itemBuilder: (context, index){
                                          String dates = snapshot.data!.articles![index].publishedAt!;
                                          List<String> date = dates.split("T");
                                          print("urlImage: ${snapshot.data!.articles![index].urlToImage}");
                                          String image = "";
                                          if(snapshot.data!.articles![index].urlToImage!=null){
                                            image = snapshot.data!.articles![index].urlToImage!;
                                          }
                                          return Container(
                                            width: 240,
                                            height: 400,
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color: Colors.blueAccent),
                                            child: Stack(
                                              fit: StackFit.loose,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: image,
                                                  imageBuilder: (context, imageProvider) => Container(
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                  ),
                                                  placeholder: (context, url) => Image.network("https://image.freepik.com/free-vector/loading-icon_167801-436.jpg"),
                                                  errorWidget: (context, url, error) => Icon(Icons.broken_image_rounded,
                                                    size: 80.0,),
                                                ),

                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                      child: Text(snapshot.data!.articles![index].title!,
                                                        style: TextStyle(fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                            backgroundColor: Colors.grey.withOpacity(0.7)
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(12.0),
                                                      child: Text(date[0],
                                                        style: TextStyle(fontSize: 13,
                                                            fontStyle: FontStyle.italic,
                                                            color: Colors.white,
                                                            backgroundColor: Colors.grey.withOpacity(0.7)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  );
                                } else if(snapshot.hasError){
                                  return Text("${snapshot.error} | ${snapshot.stackTrace.toString()}");
                                }

                                return Center(child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                      )

                  ),
                  bottom: TabBar(
                    controller: _tabController,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.blueAccent,
                    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Business',),
                      Tab(text: 'Entertainment',),
                      Tab(text: 'Health',),
                      Tab(text: 'Science',),
                      Tab(text: 'Sport',),
                      Tab(text: 'Technology',),
                    ],
                  ),
                ),

            )

          ];
        },


        body: TabBarView(
          controller: _tabController,
          children: [
            newsListCategory(category[0],
                HeadlineRepo().fetchHeadlineByCategory(category[0])),
            newsListCategory(category[1],
                HeadlineRepo().fetchHeadlineByCategory(category[1])),
            newsListCategory(category[2],
                HeadlineRepo().fetchHeadlineByCategory(category[2])),
            newsListCategory(category[3],
                HeadlineRepo().fetchHeadlineByCategory(category[3])),
            newsListCategory(category[4],
                HeadlineRepo().fetchHeadlineByCategory(category[4])),
            newsListCategory(category[5],
                HeadlineRepo().fetchHeadlineByCategory(category[5])),
          ],
        ),
      ),

      );

  }
}

Widget newsListCategory(String category, Future<Headline> futureCategory){
  return Builder(
    builder: (BuildContext context){
      return Container(
        margin: EdgeInsets.only(top: 42),
        child: FutureBuilder<Headline>(
          future: futureCategory,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index){
                    String dates = snapshot.data!.articles![index].publishedAt!;
                    List<String> date = dates.split("T");
                    print("urlImage: ${snapshot.data!.articles![index].urlToImage}");
                    String image = "";
                    if(snapshot.data!.articles![index].urlToImage!=null){
                      image = snapshot.data!.articles![index].urlToImage!;
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: CachedNetworkImage(
                              width: 90,
                              height: 90,
                              imageUrl: image,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                              placeholder: (context, url) => Image.network("https://image.freepik.com/free-vector/loading-icon_167801-436.jpg"),
                              errorWidget: (context, url, error) => Icon(Icons.broken_image_rounded,
                                size: 90.0,),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(snapshot.data!.articles![index].title!,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),

                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            color: Colors.blueAccent),
                                        child: Text(snapshot.data!.articles![index].source!.name!,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(date[0],
                                          style: TextStyle(color: Colors.grey),
                                          textAlign: TextAlign.end,),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
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
      );
  }
  );
}






