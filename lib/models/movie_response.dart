import 'package:movie_app/models/movie.dart';

class MovieResponse {
  String maximumDate;
  String minimumDate;
  int page;
  List<Movie> movies;
  int totalPages;
  int totalResults;

  MovieResponse(
      {required this.maximumDate,
      required this.minimumDate,
      required this.page,
      required this.movies,
      required this.totalPages,
      required this.totalResults});

  factory MovieResponse.fromJson(Map<String, dynamic> map) {
    return MovieResponse(
        maximumDate: map["dates"]?["maximum"] ?? "",
        minimumDate: map["dates"]?["minimum"] ?? "",
        page: map["page"] ?? 0,
        movies: (map["results"] as List)
            .map((item) => Movie.fromJson(item))
            .toList(),
        totalPages: map["total_pages"],
        totalResults: map["total_results"]);
  }
}
