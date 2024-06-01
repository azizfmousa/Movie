// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:intl/intl.dart';

class Movie {
  String title;
  String image;
  // num popularity;
  double voteAvarage;
  String discription;
  DateTime releaseDate;
  int id;
  Movie({
    required this.title,
    required this.image,
    required this.voteAvarage,
    required this.discription,
    required this.releaseDate,
    required this.id,
  });
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      image: 'http://image.tmdb.org/t/p/w500/${json['backdrop_path']}',
      voteAvarage: json['vote_average'],
      discription: json['overview'],
      id: json['id'],
      releaseDate: DateFormat('y').parse(json['release_date']),
    );
  }
}
