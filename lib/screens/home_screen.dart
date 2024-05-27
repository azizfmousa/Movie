import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:movie_app/data/movie.dart';
import 'package:movie_app/screens/details_movie_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = [];

  Future<List<Movie>> getData() async {
    final dio = Dio();

    const apiKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMGU3Zjg2ZDUxZmQ5ZjFjMTFkNDFiZWE0OWUxNGYyNSIsInN1YiI6IjU3OWY1OTRjYzNhMzY4MTZlYjAwMWFiMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6fBb-vZSqVehkMduXoIE9O0BZKEZTnBPtA9GJ7gwiTc';

    final response = await dio.get('https://api.themoviedb.org/3/movie/popular',
        options: Options(headers: {"Authorization": "Bearer $apiKey"}));

    List data = response.data['results'];

    for (final movie in data) {
      Movie move = Movie(
        title: movie['title'],
        image: 'http://image.tmdb.org/t/p/w500/${movie['backdrop_path']}',
        voteAvarage: movie['vote_average'],
        discription: movie['overview'],
        id: movie['id'],
        releaseDate: DateFormat('y').parse(movie['release_date']),
      );
      movies.add(move);
      log(movie.toString());
    }

    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Movies Page'),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            log(snapshot.connectionState.toString());
            log(snapshot.hasData.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 185 / 278,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              movie: snapshot.data![index],
                            ),
                          ),
                        );
                      },
                      child: Image.network(
                        snapshot.data![index].image,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              } else {
                return const Text("error");
              }
            }
            return const Text('data');
          },
        ));
  }
}
