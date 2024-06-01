import 'package:flutter/material.dart';

import 'package:movie_app/data/movies_type_screens.dart';
import 'package:movie_app/screens/now_playing_screen.dart';
import 'package:movie_app/screens/top_rated_screen.dart';
import 'package:movie_app/screens/upcomming_movies_screen.dart';
import 'package:pager/pager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Popular Movies'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Movies List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.movie),
                title: const Text('Now Playing'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NowPlayingScreen(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.movie_filter_sharp),
                title: const Text('Popular'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.rate_review),
                title: const Text('Top Rated'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TopRated(),
                  ));
                },
              ),
              ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UpComing(),
                  ),
                ),
                leading: const Icon(Icons.movie_creation_sharp),
                title: const Text('Upcomming'),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(child: bodyOfScreens('popular', _currentPage)),
            Pager(
              currentPage: _currentPage,
              totalPages: 5,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ],
        ));
  }
}
