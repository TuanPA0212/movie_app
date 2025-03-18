import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/app_logger.dart';

import '../models/movie.dart';
import '../repository/movie_repository.dart';

class MovieViewModel extends ChangeNotifier {
  final MovieRepository _repository = MovieRepository();
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _upComingMovies = [];
  bool _isLoading = false;

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get upComingMovies => _upComingMovies;
  bool get isLoading => _isLoading;

  Future<void> fetchNowPlayingMovie() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.fetchNowPlayingMovies();
      _nowPlayingMovies = response.movies;
    } catch (e) {
      AppLogger.logger.e("Error now playing movies view model: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTopRatedMovie() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.fetchTopRatedMovies();
      _topRatedMovies = response.movies;
    } catch (e) {
      AppLogger.logger.e("Error popular movies view model: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUpcomingMovie() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.fetchUpcomingMovies();
      _upComingMovies = response.movies;
    } catch (e) {
      AppLogger.logger.e("Error popular movies view model: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

}





