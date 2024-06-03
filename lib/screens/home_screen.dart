import 'package:flutter/material.dart';
import 'package:movie_app/page_content/drawer_part/drawer_part.dart';
import 'package:movie_app/page_content/app_bar_part.dart/app_bar_part.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movie_app/data/movies_type_screens.dart';
import 'package:movie_app/providers/provider_movies_type';

import 'package:pager/pager.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentPage = 1;
  @override
  Widget build(BuildContext context) {
    final activeScreen = ref.watch(typeProvider);
    String titleOFPage(String activescree) {
      if (activeScreen == 'now_playing') {
        return 'Now Playing Movies';
      }
      if (activeScreen == 'top_rated') {
        return 'Top Rated Movies';
      }
      if (activeScreen == 'upcoming') {
        return 'upcoming Movies';
      }

      return 'popular Movies';
    }

    return Scaffold(
        appBar: MyAppBar(
          title: titleOFPage(activeScreen),
        ),
        drawer: const DrawerPart(),
        body: Column(
          children: [
            Expanded(child: bodyOfScreens(activeScreen, _currentPage)),
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
