import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:movies_db/search_result.dart';
import 'package:movies_db/utils/text.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({super.key});

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: textController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 0.8, color: Colors.white),
                    ),
                    hintText: 'Seach Movies and Shows',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        textController.clear();
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ModifiedText(
                  text: 'Popular Genres', color: Colors.white, size: 20),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 4),
                  ),
                  itemCount: 4, // Number of items
                  itemBuilder: (BuildContext context, int index) {
                    List<String> containerNames = [
                      'Action',
                      'Adventure',
                      'Animation',
                      'Comedy'
                    ];
                    List<Color> selectedColor = [
                      Color.fromARGB(255, 172, 146, 18),
                      Color.fromARGB(255, 4, 65, 116),
                      Color.fromARGB(255, 80, 228, 248),
                      Color.fromARGB(255, 44, 41, 12)
                    ];
                    List<String> imageUrls = [
                      'https://rukminim1.flixcart.com/image/850/1000/jf8khow0/poster/a/u/h/small-hollywood-movie-poster-blade-runner-2049-ridley-scott-original-imaf3qvx88xenydd.jpeg?q=20',
                      'https://i.pinimg.com/564x/2c/29/68/2c2968fce78e41f0916295e2f1792462.jpg',
                      'https://w0.peakpx.com/wallpaper/331/764/HD-wallpaper-onward-movie-poster-movies-2020-cartoon-animation-hollywood.jpg',
                      'https://c8.alamy.com/comp/PMBRKE/bob-magnum-dwayne-johnson-calvin-joyner-kevin-hart-in-new-line-cinemas-and-universal-pictures-action-comedy-central-intelligence-a-warner-bros-pictures-release-poster-PMBRKE.jpg',
                    ];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: selectedColor[index],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: ModifiedText(
                                      text: containerNames[index],
                                      color: Colors.white,
                                      size: 20)),
                            ),
                            Positioned(
                              top: 5,
                              right: 10,
                              child: Image.network(
                                imageUrls[index],
                                width: 40, // Adjust the image width as needed
                                height: 70, // Adjust the image height as needed
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ModifiedText(text: 'Browse All', color: Colors.white, size: 20),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
