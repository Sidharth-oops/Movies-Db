import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movies_db/utils/text.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Description extends StatefulWidget {
  const Description(
      {super.key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.launchOn,
      required this.id});
  final String name, description, bannerurl, posterurl, vote, launchOn;
  final int id;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool isLoading = true;
  List movieCast = [];

  String apiKey = "073e436431b54f77e5aa6fe680c0760f";
  final readAccessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNzNlNDM2NDMxYjU0Zjc3ZTVhYTZmZTY4MGMwNzYwZiIsInN1YiI6IjY0Y2NhZDkyNzY0Yjk5MDEwMDg5ZjYwYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fI96yWDfXLiO94ysRr0Lpc_iYgQeHuKRDa5XvFqM3sQ";

  void initState() {
    loadCast();
    _loadDataWithDelay();

    super.initState();
  }

  void loadCast() async {
    TMDB tmdbwithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true),
    );

    Map castMovie = await tmdbwithCustomLogs.v3.movies.getCredits(widget.id);
    setState(() {
      movieCast = castMovie['cast'];
    });
  }

  void _loadDataWithDelay() async {
    await Future.delayed(Duration(seconds: 3)); // Adding a 3-second delay
    // Perform your data loading here

    setState(() {
      isLoading = false; // Data is loaded, set isLoading to false
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        centerTitle: true,
        title:
            ModifiedText(text: 'Description ❤️', color: Colors.cyan, size: 16),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Add your action here
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        widget.bannerurl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: ModifiedText(
                        text: '⭐AverageRating-' + widget.vote + "/10",
                        color: Colors.white,
                        size: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ModifiedText(
                  text: widget.name != null ? widget.name : 'Not loaded',
                  color: Colors.white,
                  size: 25),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: ModifiedText(
                  text: 'Released On-' + widget.launchOn,
                  color: Colors.white,
                  size: 14),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(widget.posterurl),
                ),
                Flexible(
                  child: Container(
                    child: ModifiedText(
                        text: widget.description,
                        color: Colors.white,
                        size: 18),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: ModifiedText(
                      text: 'CAST', color: Colors.white, size: 24)),
            ),
            Container(
              child: isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(), // Show loading spinner
                    )
                  : Container(
                      height: 150,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: movieCast[index]['profile_path'] != null
                                ? Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'http://image.tmdb.org/t/p/w500' +
                                                  movieCast[index]
                                                      ['profile_path'],
                                          imageBuilder:
                                              ((context, imageProvider) {
                                            return CircleAvatar(
                                              backgroundImage: imageProvider,
                                              radius: 50,
                                            );
                                          }),
                                          placeholder: ((context, url) {
                                            return CircleAvatar(
                                              backgroundColor: Colors.black,
                                              radius: 50,
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }),
                                        ),
                                      ),
                                      Text(
                                        movieCast[index]['name'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: movieCast.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
