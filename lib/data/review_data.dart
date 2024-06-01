// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class Reviews {
  String name;
  String content;
  DateTime time;
  Reviews({
    required this.name,
    required this.content,
    required this.time,
  });
  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      name: json['author'],
      content: json['content'],
      time: DateFormat('yyyy-MM-ddThh:mm:ss').parse(
        json['created_at'],
      ),
    );
  }
}
