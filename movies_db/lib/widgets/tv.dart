// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movies_db/description.dart';
import 'package:movies_db/utils/text.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class Tve extends StatefulWidget {
  const Tve({
    Key? key,
    required this.trendingMovies,
  }) : super(key: key);
  final List trendingMovies;

  @override
  State<Tve> createState() => _TveState();
}

class _TveState extends State<Tve> {
  List<bool> isLikedList = [];
  @override
  void initState() {
    super.initState();

    isLikedList = List.generate(1000, (index) => false);
  }

  void toggleLike(int index) {
    setState(() {
      isLikedList[index] = !isLikedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ModifiedText(
                text: 'Popular Tv Shows', color: Colors.white, size: 20),
          ),
          Container(
            height: 230,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          name: widget.trendingMovies[index]['original_name'],
                          bannerurl: 'http://image.tmdb.org/t/p/w500' +
                              widget.trendingMovies[index]['backdrop_path'],
                          posterurl: 'http://image.tmdb.org/t/p/w500' +
                              widget.trendingMovies[index]['poster_path'],
                          description: widget.trendingMovies[index]['overview'],
                          vote: widget.trendingMovies[index]['vote_average']
                              .toString(),
                          launchOn: widget.trendingMovies[index]
                              ['first_air_date'],
                              id: widget.trendingMovies[index]['id'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 140,
                    child: widget.trendingMovies[index]['original_name'] != null
                        ? Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: 'http://image.tmdb.org/t/p/w500' +
                                    widget.trendingMovies[index]['poster_path'],
                                imageBuilder: (context, imageProvider) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 1,
                                        right: 1,
                                        child: IconButton(
                                          onPressed: () => toggleLike(index),
                                          icon: Icon(
                                            isLikedList[index]
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isLikedList[index]
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                placeholder: (context, url) {
                                  return Container(
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                child: ModifiedText(
                                    text: widget.trendingMovies[index]
                                                ['original_name'] !=
                                            null
                                        ? widget.trendingMovies[index]
                                            ['original_name']
                                        : 'Loading',
                                    color: Colors.white,
                                    size: 10),
                              )
                            ],
                          )
                        : Container(),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: widget.trendingMovies.length,
            ),
          ),
        ],
      ),
    );
  }
}
