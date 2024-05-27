// ignore_for_file: public_member_api_docs, sort_constructors_first

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
}
