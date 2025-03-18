import 'package:flutter/material.dart';
import 'package:movie_app/core/api_constants.dart';
import 'package:movie_app/core/theme/app_text_style.dart';
import 'package:movie_app/viewmodels/movie_view_model.dart';
import 'package:movie_app/viewmodels/navigation_view_model.dart';
import 'package:movie_app/views/myNetflix/my_netflix.dart';
import 'package:provider/provider.dart';

import '../newAndHot/new_and_hot.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _pages = [
    HomeTab(),
    NewAndHotTab(),
    MyNetflix(),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final movieProvider = Provider.of<MovieViewModel>(context, listen: false);
      movieProvider.fetchNowPlayingMovie();
      movieProvider.fetchTopRatedMovie();
      movieProvider.fetchUpcomingMovie();
    });
  }

  @override
  Widget build(context) {
    final navigationProvider = Provider.of<NavigationViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          navigationProvider.currentIndex == 0
              ? "My Netflix"
              : navigationProvider.currentIndex == 1
                  ? "New & Hot"
                  : "For PATzz",
          style: AppTextStyle.textTitle,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 32,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                size: 32,
              ))
        ],
      ),
      body: _pages[navigationProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.currentIndex,
        onTap: navigationProvider.setTabIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_library_outlined), label: "New & Hot"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/avatar.png",
                height: 24,
                width: 24,
              ),
              label: "My Netflix"),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(context) {
    final movieProvider = Provider.of<MovieViewModel>(context);

    return movieProvider.isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
            children: [
              NowPlayingList(),
              SizedBox(height: 16),
              PopularList(),
              SizedBox(height: 16),
              UpcomingList(),
              SizedBox(height: 16),
            ],
          ));
  }
}

class NowPlayingList extends StatelessWidget {
  const NowPlayingList({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieViewModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Now Playing"),
            )
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: screenHeight * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieProvider.nowPlayingMovies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.nowPlayingMovies[index];
                return Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        "${ApiConstants.imageBaseUrl}${movie.posterPath}",
                        width: screenWidth * 0.30,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image);
                        },
                      ),
                    ));
              },
            ),
          ),
        )
      ],
    );
  }
}

class PopularList extends StatelessWidget {
  const PopularList({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieViewModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Top Rated"),
            )
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: screenHeight * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieProvider.topRatedMovies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.topRatedMovies[index];
                return Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        "${ApiConstants.imageBaseUrl}${movie.posterPath}",
                        width: screenWidth * 0.30,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image);
                        },
                      ),
                    ));
              },
            ),
          ),
        )
      ],
    );
  }
}

class UpcomingList extends StatelessWidget {
  const UpcomingList({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieViewModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Upcoming"),
            )
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: screenHeight * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieProvider.upComingMovies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.upComingMovies[index];
                return Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        "${ApiConstants.imageBaseUrl}${movie.posterPath}",
                        width: screenWidth * 0.30,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image);
                        },
                      ),
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }
}
