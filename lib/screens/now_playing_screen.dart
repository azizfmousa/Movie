import 'package:flutter/material.dart';
import 'package:movie_app/data/movies_type_screens.dart';
import 'package:pager/pager.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  int _currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Now Playing Movies'),
      ),
      body: Column(
        children: [
          Expanded(child: bodyOfScreens('now_playing', _currentPage)),
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
