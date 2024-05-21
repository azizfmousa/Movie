// ignore_for_file: public_member_api_docs, sort_constructors_first
class Movie {
  String title;
  String image;
  num popularity;
  num? voteAvarage;
  Movie({
    required this.title,
    required this.image,
    required this.popularity,
    required this.voteAvarage,
  });
}
