import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netflix_clone/models/tmdb_trending_model.dart';
import 'package:netflix_clone/services/api_services.dart';

import '../../../domain/data/utils.dart';
import '../home/movie_detail_screen.dart';

class HotNews extends StatefulWidget {
  const HotNews({super.key});

  @override
  State<HotNews> createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  final ApiServices apiServices = ApiServices();
  late Future<TmdbTrending?> tmdbTrending;

  @override
  void initState() {
    tmdbTrending = apiServices.tmdbTrending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String getShortName(String name) {
      return name.length > 3 ? name.substring(0, 3) : name;
    }

    String formatDate(String? apiDate) {
      if (apiDate == null || apiDate.isEmpty) return "";
      final date = DateTime.tryParse(apiDate);
      if (date == null) return "";
      return DateFormat('MMM').format(date);
    }

    String getDay(String? apiDate) {
      if (apiDate == null || apiDate.isEmpty) return "";
      final date = DateTime.tryParse(apiDate);
      return date != null ? date.day.toString() : "";
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Hot News"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<TmdbTrending?>(
        future: tmdbTrending,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error : ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final movies = snapshot.data!.results ?? [];
            return ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailScreen(movieId: movie.id!),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Text(
                                movie.releaseDate == null
                                    ? getDay(movie.releaseDate)
                                    : getDay(movie.firstAirDate),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                              Text(
                                getShortName(
                                  formatDate(
                                    movie.releaseDate == null
                                        ? movie.releaseDate
                                        : movie.firstAirDate,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      "$imgUrl${movie.backdropPath}",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Coming On",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    movie.releaseDate == null
                                        ? getDay(movie.releaseDate)
                                        : getDay(movie.firstAirDate),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    getShortName(
                                      formatDate(
                                        movie.releaseDate == null
                                            ? movie.releaseDate
                                            : movie.firstAirDate,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.info,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                movie.overview!,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Problem to fetch data"));
          }
        },
      ),
    );
  }
}
