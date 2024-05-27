import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/data/genres_calss.dart';
import 'package:readmore/readmore.dart';

import 'package:movie_app/data/movie.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.movie,
  });
  final Movie movie;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List trailers = [];

  Future<List<GenresMoive>> genresList() async {
    final dio = Dio();
    const apiKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMGU3Zjg2ZDUxZmQ5ZjFjMTFkNDFiZWE0OWUxNGYyNSIsInN1YiI6IjU3OWY1OTRjYzNhMzY4MTZlYjAwMWFiMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6fBb-vZSqVehkMduXoIE9O0BZKEZTnBPtA9GJ7gwiTc';

    final response = await dio.get(
      'https://api.themoviedb.org/3/movie/${widget.movie.id}',
      options: Options(
        headers: {"Authorization": "Bearer $apiKey"},
      ),
    );

    List genres = response.data['genres'];
    List<GenresMoive> listGenr = genres.map((e) => GenresMoive(id: e['id'], name: e['name'])).toList();
    log(listGenr.toString());
    return listGenr;
  }

  Future<List> vedioKey() async {
    final dio = Dio();
    const apiKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMGU3Zjg2ZDUxZmQ5ZjFjMTFkNDFiZWE0OWUxNGYyNSIsInN1YiI6IjU3OWY1OTRjYzNhMzY4MTZlYjAwMWFiMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6fBb-vZSqVehkMduXoIE9O0BZKEZTnBPtA9GJ7gwiTc';
    final response = await dio.get(
      'https://api.themoviedb.org/3/movie/${widget.movie.id}/videos',
      options: Options(
        headers: {'Authorization': 'Bearer $apiKey'},
      ),
    );
    List results = response.data['results'];
    trailers = results.map((e) => e['key']).toList();
    log(trailers.toString());
    log(response.statusCode.toString());
    return trailers;
  }

  @override
  void initState() {
    super.initState();
    vedioKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: genresList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Image.network(
                        widget.movie.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: [
                              RatingBarIndicator(
                                itemSize: 20,
                                rating: widget.movie.voteAvarage / 2,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  opticalSize: .1,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                widget.movie.voteAvarage.toStringAsFixed(2),
                                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(DateFormat('y').format(widget.movie.releaseDate)),
                              const Icon(Icons.arrow_right_outlined),
                              ...snapshot.data!.map((GenresMoive e) => Text('${e.name}  ')),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ReadMoreText(
                            widget.movie.discription,
                            trimMode: TrimMode.Line,
                            trimLines: 2,
                            colorClickableText: Colors.blue,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Card(
                            elevation: 2,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                              width: double.infinity,
                              height: 40,
                              child: const Text(
                                // textAlign: TextAlign.center,
                                'Trailer',
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: trailers.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                'https://img.youtube.com/vi/${trailers[index]}/mqdefault.jpg',
                                fit: BoxFit.cover,
                                width: 200,
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Text('error');
            }
          }
          return const Text('data');
        },
      ),
    );
  }
}
