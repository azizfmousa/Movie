import 'package:flutter/material.dart';
import 'package:movie_app/data/movies_type_screens.dart';
import 'package:pager/pager.dart';

class UpComing extends StatefulWidget {
  const UpComing({super.key});

  @override
  State<UpComing> createState() => _UpComingState();
}

class _UpComingState extends State<UpComing> {
  int _currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('upComing Movies'),
      ),
      body: Column(
        children: [
          Expanded(child: bodyOfScreens('upcoming', _currentPage)),
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
