import 'package:flutter/cupertino.dart';

import '../models/movie.dart';
import '../repository/movie_repository.dart';

class MovieViewModel extends ChangeNotifier {
  final MovieRepository _repository = MovieRepository();
  List<Movie> _movies = [];
  bool _isLoading = false;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> fetchNowPlayingMovie() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.fetchNowPlayingMovies();
      _movies = response.movies;
    } catch (e) {
      debugPrint("Error movies view model: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
}





