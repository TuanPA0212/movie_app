import 'package:flutter/material.dart';
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
    Future.microtask(() =>
        Provider.of<MovieViewModel>(context, listen: false)
            .fetchNowPlayingMovie());
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
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 32,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu, size: 32,))
        ],
      ),
      body: _pages[navigationProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.white.withOpacity(0.2),
        currentIndex: navigationProvider.currentIndex,
        onTap: navigationProvider.setTabIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_library_outlined), label: "New & Hot"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/avatar.png", height: 24, width: 24,), label: "My Netflix"),
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
    // : movieProvider.errorMessage.isNotEmpty
    // ? Center(child: Text(movieViewModel.errorMessage))
        : ListView.builder(
            itemCount: movieProvider.movies.length,
            itemBuilder: (context, index) {
              final movie = movieProvider.movies[index];
              return ListTile(
                // leading: Image.network(
                //   "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                //   width: 50,
                //   fit: BoxFit.cover,
                // ),
                title: Text(movie.title),
                subtitle: Text("⭐ ${movie.voteAverage}"),
              );
            },
          );
  }
}
