import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:movie_app/core/endpoints.dart';
import 'package:movie_app/models/movie_response.dart';

import '../core/api_constants.dart';

abstract interface class Repository {
  Future<MovieResponse> fetchNowPlayingMovies();

  Future<MovieResponse> fetchTopRatedMovies();

  Future<MovieResponse> fetchUpcomingMovies();
}

class MovieRepository implements Repository {
  var logger = Logger();

  @override
  Future<MovieResponse> fetchNowPlayingMovies() async {
    final url =
        '${ApiConstants.baseUrl}/${MovieEndpoints.nowPlaying}?api_key=${ApiConstants.apiKey}&language=en-US&page=1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load now playing movies repository");
    }
  }

  @override
  Future<MovieResponse> fetchTopRatedMovies() async {
    final url =
        '${ApiConstants.baseUrl}/${MovieEndpoints.topRated}?api_key=${ApiConstants.apiKey}&language=en-US&page=1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load popular movies repository");
    }
  }

  @override
  Future<MovieResponse> fetchUpcomingMovies() async {
    final url =
        '${ApiConstants.baseUrl}/${MovieEndpoints.upcoming}?api_key=${ApiConstants.apiKey}&language=en-US&page=1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load popular movies repository");
    }
  }
}
