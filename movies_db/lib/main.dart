import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_db/drawer_screen.dart';
import 'package:movies_db/login.dart';
import 'package:movies_db/search.dart';
import 'package:movies_db/utils/text.dart';
import 'package:movies_db/widgets/top_rated.dart';
import 'package:movies_db/widgets/trending.dart';
import 'package:movies_db/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'favourite.dart';
import 'menu_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    ),
  );
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => myApp(), // Replace with your main screen widget
        ),
      );
    });
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie.json'),
      ),
    );
  }
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.defaultStyle,
      mainScreen: BottomNavigation(),
      menuScreen: MenuPage(),
    );

    // MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(brightness: Brightness.dark),
    //   home: BottomNavigation(),
    // );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  List<Widget> screen = [Home(), SearchMovie(), Favourite()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      appBar: AppBar(
        leading: DrawerScreen(),
        centerTitle: true,
        title: ModifiedText(
            text: 'Flutter Movie App ❤️', color: Colors.cyan, size: 16),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: IconThemeData(color: Colors.white),
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            backgroundColor: Colors.cyan,
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.cyan,
            activeIcon: Icon(Icons.search_off_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favourite',
            backgroundColor: Colors.cyan,
            activeIcon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingMovies = [];
  List topRatedMovies = [];
  List tvList = [];

  String apiKey = "073e436431b54f77e5aa6fe680c0760f";
  final readAccessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNzNlNDM2NDMxYjU0Zjc3ZTVhYTZmZTY4MGMwNzYwZiIsInN1YiI6IjY0Y2NhZDkyNzY0Yjk5MDEwMDg5ZjYwYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fI96yWDfXLiO94ysRr0Lpc_iYgQeHuKRDa5XvFqM3sQ";

  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    TMDB tmdbwithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true),
    );
    Map trendingreult = await tmdbwithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbwithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbwithCustomLogs.v3.tv.getPopular();
    Map castMovie = await tmdbwithCustomLogs.v3.movies.getCredits(614479);

    setState(() {
      trendingMovies = trendingreult['results'];
      topRatedMovies = topRatedResult['results'];
      tvList = tvResult['results'];
    });
    print(tvList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          TrendingMovies(
            trendingMovies: trendingMovies,
          ),
          TopRated(trendingMovies: topRatedMovies),
          Tve(trendingMovies: tvList)
        ],
      ),
    );
  }
}
