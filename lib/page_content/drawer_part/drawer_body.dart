import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/page_content/drawer_part/drawer_class_for_body.dart';
import 'package:movie_app/page_content/drawer_part/drawer_header.dart';
import 'package:movie_app/providers/provider_movies_type';

class DrawerBody extends ConsumerStatefulWidget {
  const DrawerBody({super.key});

  @override
  ConsumerState<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends ConsumerState<DrawerBody> {
  String titleMovies = 'popular';
  List<DrawerBodyClass> drawerList = [];
  @override
  void initState() {
    super.initState();
    drawerList = [
      DrawerBodyClass(
          icon: Icons.movie,
          title: 'Now Playing',
          onTap: () {
            titleMovies = 'now_playing';
            Navigator.of(context).pop();
            ref.read(typeProvider.notifier).activeTypeOfMovie(titleMovies);
          }),
      DrawerBodyClass(
          icon: Icons.movie_filter_sharp,
          title: 'Popular',
          onTap: () {
            Navigator.of(context).pop();
          }),
      DrawerBodyClass(
          icon: Icons.rate_review,
          title: 'Top Rated',
          onTap: () {
            titleMovies = 'top_rated';
            Navigator.of(context).pop();
            ref.read(typeProvider.notifier).activeTypeOfMovie(titleMovies);
          }),
      DrawerBodyClass(
          icon: Icons.movie_creation_sharp,
          title: 'Upcomming',
          onTap: () {
            titleMovies = 'upcoming';
            Navigator.of(context).pop();
            ref.read(typeProvider.notifier).activeTypeOfMovie(titleMovies);
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const HeadOfDrawer(),
        ...drawerList.map(
          (element) => ListTile(
            leading: Icon(element.icon),
            title: Text(element.title),
            onTap: element.onTap,
          ),
        )
      ],
    );
  }
}
