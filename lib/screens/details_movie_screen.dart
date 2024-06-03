// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:movie_app/data/genres_calss.dart';
import 'package:movie_app/data/movie.dart';
import 'package:movie_app/data/review_data.dart';
import 'package:movie_app/page_content/app_bar_part.dart/app_bar_part.dart';

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
    setState(() {});
    log(trailers.toString());
    log(response.statusCode.toString());
    return trailers;
  }

  List<Reviews> rev = [];

  Future<List> reviews() async {
    rev = [];
    final dio = Dio();
    const apiKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMGU3Zjg2ZDUxZmQ5ZjFjMTFkNDFiZWE0OWUxNGYyNSIsInN1YiI6IjU3OWY1OTRjYzNhMzY4MTZlYjAwMWFiMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6fBb-vZSqVehkMduXoIE9O0BZKEZTnBPtA9GJ7gwiTc';
    final response = await dio.get(
      'https://api.themoviedb.org/3/movie/${widget.movie.id}/reviews',
      options: Options(
        headers: {'Authorization': 'Bearer $apiKey'},
      ),
    );
    List results = response.data['results'];
    rev = results.map((e) => Reviews.fromJson(e)).toList();
    setState(() {});
    log(rev.toString());
    log(response.statusCode.toString());
    return rev;
  }

  @override
  void initState() {
    super.initState();
    vedioKey();
    reviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Details'),
      body: FutureBuilder(
        future: genresList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                //col
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
                              //rating bar
                              RatingBar(widget: widget),
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
                          //Readmore
                          ReadMore(
                            content: widget.movie.discription,
                            widget: widget,
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
                                'Trailers',
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
                          //listview
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: trailers.take(3).length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  _launchURL(trailers[index]);
                                },
                                child: Image.network(
                                  'https://img.youtube.com/vi/${trailers[index]}/mqdefault.jpg',
                                  fit: BoxFit.cover,
                                  width: 200,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //listview
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: rev.take(3).length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      rev[index].name,
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      Jiffy.parseFromDateTime(rev[index].time).fromNow(),
                                    ),
                                  ],
                                ),
                                subtitle: ReadMore(
                                  content: rev[index].content,
                                  widget: widget,
                                ),
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

  _launchURL(String key) async {
    final Uri url = Uri.parse('https://www.youtube.com/watch?v=$key');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch video');
    }
  }
}

class RatingBar extends StatelessWidget {
  const RatingBar({
    super.key,
    required this.widget,
  });

  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
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
    );
  }
}

class ReadMore extends StatelessWidget {
  const ReadMore({
    super.key,
    required this.content,
    required this.widget,
  });

  final String content;
  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      content,
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
    );
  }
}
