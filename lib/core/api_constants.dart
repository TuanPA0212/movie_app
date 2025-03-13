import 'package:movie_app/core/api_keys.dart';

class ApiConstants {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/original";
  static String getApiKey() => APIKeys.apiKey;
  static const String bigImageBaseUrl = "https://image.tmdb.org/t/p/w500";
}
