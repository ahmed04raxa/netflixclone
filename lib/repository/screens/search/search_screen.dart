import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/search_movie_model.dart';
import 'package:netflix_clone/models/trending_movie_model.dart';
import 'package:netflix_clone/repository/screens/home/movie_detail_screen.dart';
import 'package:netflix_clone/services/api_services.dart';

import '../../../domain/data/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  late Future<TrendingMovies?> trendingMovies;
  SearchMovie? searchMovie;
  void search(String query) {
    apiServices.searchMovie(query).then((result) {
      setState(() {
        searchMovie = result;
      });
    });
  }

  @override
  void initState() {
    trendingMovies = apiServices.trendingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoSearchTextField(
              controller: searchController,
              padding: EdgeInsets.all(10),
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey),
              suffixIcon: Icon(Icons.cancel, color: Colors.grey),
              backgroundColor: Colors.grey.withOpacity(0.3),
              onChanged: (value) {
                setState(() {});
                if (value.isNotEmpty) {
                  search(searchController.text);
                }
              },
            ),
            SizedBox(height: 10),
            searchController.text.isEmpty
                ? FutureBuilder(
                    future: trendingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final movie = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "Top Search",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: movie.results!.length,
                              itemBuilder: (context, index) {
                                final topMovie = movie.results![index];
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailScreen(
                                                    movieId: topMovie.id!,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 90,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "$imgUrl${topMovie.backdropPath}",
                                                fit: BoxFit.contain,
                                                width: 150,
                                              ),
                                              SizedBox(width: 20),
                                              Flexible(
                                                child: Text(
                                                  topMovie.title!,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 40,
                                      right: 20,
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: 27,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return Center(child: CircularProgressIndicator(),);
                    },
                  )
                : searchMovie == null
                ? SizedBox.shrink()
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchMovie?.results!.length,
                    itemBuilder: (context, index) {
                      final search = searchMovie!.results![index];
                      return search.backdropPath == null
                          ? SizedBox()
                          : Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailScreen(
                                                movieId: search.id!,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                "$imgUrl${search.backdropPath}",
                                            fit: BoxFit.contain,
                                            width: 150,
                                          ),
                                          SizedBox(width: 20),
                                          Flexible(
                                            child: Text(
                                              search.title!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 40,
                                  right: 20,
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                ),
                              ],
                            );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
