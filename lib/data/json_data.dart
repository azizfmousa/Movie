import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_app/data/movie.dart';

Future<List<Movie>> getData(String type, int numPage) async {
  List<Movie> movies = [];
  final dio = Dio();

  const apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMGU3Zjg2ZDUxZmQ5ZjFjMTFkNDFiZWE0OWUxNGYyNSIsInN1YiI6IjU3OWY1OTRjYzNhMzY4MTZlYjAwMWFiMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6fBb-vZSqVehkMduXoIE9O0BZKEZTnBPtA9GJ7gwiTc';

  final response = await dio.get('https://api.themoviedb.org/3/movie/$type?language=en-US&page=$numPage',
      options: Options(headers: {"Authorization": "Bearer $apiKey"}));

  List data = response.data['results'];

  for (final movie in data) {
    Movie move = Movie.fromJson(movie);
    movies.add(move);
    log(movie.toString());
  }

  return movies;
}
