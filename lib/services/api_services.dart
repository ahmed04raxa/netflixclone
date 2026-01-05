import 'dart:convert';

import 'package:netflix_clone/domain/data/utils.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/models/trending_movie_model.dart';
import 'package:netflix_clone/models/upcoming_movie_model.dart';

var key = "?api_key=$apiKey";

class ApiServices {
  // NOW PLAYING MOVIES

  Future<Movie?> fetchMovies() async {
    try {
      const endPoint = "movie/now_playing";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Movie.fromJson(jsonData);
      } else {
        throw Exception("Failed To Load movies");
      }
    } catch (e) {
      return null;
    }
  }

  // UPCOMING MOVIES
  Future<UpcomingMovies?> upComingMovies() async {
    try {
      const endPoint = "movie/upcoming";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return UpcomingMovies.fromJson(jsonData);
      } else {
        throw Exception("Failed To Load upcoming movies");
      }
    } catch (e) {
      return null;
    }
  }

  // TRENDING MOVIES
  Future<TrendingMovies?> trendingMovies() async {
    try {
      const endPoint = "trending/movie/day";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return TrendingMovies.fromJson(jsonData);
      } else {
        throw Exception("Failed To Load upcoming movies");
      }
    } catch (e) {
      return null;
    }
  }
}
