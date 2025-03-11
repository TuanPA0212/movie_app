class Movie {
  bool adult;
  String backdropPath;
  List<dynamic> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie(
      {required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
        adult: map["adult"],
        backdropPath: map["backdrop_path"] ?? "",
        genreIds: map["genre_ids"] ?? "",
        id: map["id"] ?? "",
        originalLanguage: map["original_language"] ?? "",
        originalTitle: map["original_title"] ?? "",
        overview: map["overview"] ?? "",
        popularity: (map["popularity"] ?? 0).toDouble(),
        posterPath: map["poster_path"] ?? "",
        releaseDate: map["release_date"] ?? "",
        title: map["title"] ?? "",
        video: map["video"] ?? "",
        voteAverage: (map["vote_average"] ?? 0).toDouble(),
        voteCount: map["vote_count"] ?? 0);
  }

  @override
  String toString() {
    return 'Movie{adult: $adult, backdropPath: $backdropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
  }
}
