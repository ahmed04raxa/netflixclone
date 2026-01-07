import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:netflix_clone/domain/data/utils.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/models/popular_tv_series_model.dart';
import 'package:netflix_clone/models/top_rated_movie_model.dart';
import 'package:netflix_clone/models/trending_movie_model.dart';
import 'package:netflix_clone/models/upcoming_movie_model.dart';
import 'package:netflix_clone/repository/screens/home/movie_detail_screen.dart';
import 'package:netflix_clone/repository/screens/search/search_screen.dart';
import 'package:netflix_clone/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices apiServices = ApiServices();
  late Future<Movie?> movieData;
  late Future<UpcomingMovies?> upcomingMovies;
  late Future<TrendingMovies?> trendingMovies;
  late Future<TopRatedMovie?> topRatedMovies;
  late Future<PopularTvSeries?> popularTvSeries;

  @override
  void initState() {
    movieData = apiServices.fetchMovies();
    upcomingMovies = apiServices.upComingMovies();
    trendingMovies = apiServices.trendingMovies();
    topRatedMovies = apiServices.topRatedMovies();
    popularTvSeries = apiServices.popularTvSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logos_netflix.png",
                    height: 100,
                    width: 100,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                    icon: Icon(
                      Iconsax.search_normal,
                      size: 27,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.download, size: 27, color: Colors.white),
                  SizedBox(width: 10),
                  Icon(Icons.cast, size: 27, color: Colors.white),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Text(
                      "TV Shows",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Text(
                      "Movies",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 530,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: FutureBuilder(
                      future: upcomingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error : ${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          final movies = snapshot.data!.results ?? [];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: PageView.builder(
                              itemCount: movies.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailScreen(
                                          movieId: movie.id!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 338,
                                    height: 530,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          "$imgUrl${movie.posterPath}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(child: Text("Problem to fetch data"));
                        }
                      },
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                Text(
                                  "Play",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.white, size: 30),
                                Text(
                                  "Playlist",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            moviesType(
              future: trendingMovies,
              movieType: "Trending Movies on Netflix",
            ),
            moviesType(
              future: upcomingMovies,
              movieType: "UpComing Movies",
              isReserve: true,
            ),
            moviesType(
              future: popularTvSeries,
              movieType: "Popular Tv Series - Most - Watch For You",
            ),
            moviesType(future: topRatedMovies, movieType: "Top Rated Movies"),
          ],
        ),
      ),
    );
  }

  Padding moviesType({
    required Future future,
    required String movieType,
    bool isReserve = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieType,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 180,
            width: double.maxFinite,
            child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error : ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final movies = snapshot.data!.results ?? [];
                  return ListView.builder(
                    reverse: isReserve,
                    itemCount: movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
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
                          child: Container(
                            width: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  "$imgUrl${movie.posterPath}",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
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
          ),
        ],
      ),
    );
  }
}
