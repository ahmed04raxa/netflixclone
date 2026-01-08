import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:netflix_clone/repository/screens/home/home_screen.dart';
import 'package:netflix_clone/repository/screens/hotnews/hot_news.dart';
import 'package:netflix_clone/repository/screens/search/search_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Iconsax.home5), text: "HOME"),
              Tab(icon: Icon(Iconsax.search_normal), text: "Search"),
              Tab(icon: Icon(Icons.photo_library), text: "Hot News"),
            ],
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
          ),
        ),
        body: TabBarView(children: [HomeScreen(), SearchScreen(), HotNews()]),
      ),
    );
  }
}
