import 'package:flutter/material.dart';
import 'package:movie_app/data/movies_type_screens.dart';
import 'package:pager/pager.dart';

class TopRated extends StatefulWidget {
  const TopRated({super.key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  int _currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Top Rated Movies'),
      ),
      body: Column(
        children: [
          Expanded(child: bodyOfScreens('top_rated', _currentPage)),
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
      ),
    );
  }
}
