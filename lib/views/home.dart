import 'package:flutter/material.dart';
import 'package:movie_app/viewmodels/movie_view_model.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MovieViewModel>(context, listen: false).fetchNowPlayingMovie()
    );
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieViewModel>(context);
    return  Scaffold(
      appBar: AppBar(title: Text("Now Playing Movies")),
      body: movieProvider.isLoading
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
      ),
    );
  }
}


