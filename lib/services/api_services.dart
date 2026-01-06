import 'dart:convert';

import 'package:netflix_clone/domain/data/utils.dart';
import 'package:netflix_clone/models/movie_detail_model.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/models/movie_recommendations_model.dart';
import 'package:netflix_clone/models/popular_tv_series_model.dart';
import 'package:netflix_clone/models/top_rated_movie_model.dart';
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

  // Top Rated Movies
  Future<TopRatedMovie?> topRatedMovies() async {
    try {
      const endPoint = "movie/top_rated";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return TopRatedMovie.fromJson(jsonData);
      } else {
        throw Exception("Failed To Load top rated movies");
      }
    } catch (e) {
      return null;
    }
  }

  // Popular Tv Series
  Future<PopularTvSeries?> popularTvSeries() async {
    try {
      const endPoint = "tv/popular";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return PopularTvSeries.fromJson(jsonData);
      } else {
        throw Exception("Failed To Load top rated movies");
      }
    } catch (e) {
      return null;
    }
  }

  // Movie Detail
  Future<MovieDetail?> movieDetail(int movieId) async {
    try {
      final endPoint = "movie/$movieId";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return MovieDetail.fromJson(jsonData);
      } else {
        throw Exception("Failed To Load top rated movies");
      }
    } catch (e) {
      return null;
    }
  }

  // Movie Recommendations
  Future<MovieRecommendations?> movieRecommendations(int movieId) async {
    try {
      final endPoint = "movie/$movieId/recommendations";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return MovieRecommendations.fromJson(jsonData);
      } else {
        throw Exception("Failed To Load top rated movies");
      }
    } catch (e) {
      return null;
    }
  }
}
