import 'package:firebase_database/firebase_database.dart';

class Movie{
  String key;
  String title;
  String year;
  String posterUrl;
  bool finished;

  Movie({this.title, this.year, this.posterUrl, this.finished});

  Movie.fromSnapshot(DataSnapshot snapshot):
        key = snapshot.key,
        title = snapshot.value['title'],
        year = snapshot.value['year'],
        posterUrl = snapshot.value['posterUrl'],
        finished = snapshot.value['finished'];

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      title: json['Title'],
      year: json['Year'],
      posterUrl: json['Poster'],
      finished: false,
    );
  }

  toJson() {
    return {
      'title': title,
      'year': year,
      'posterUrl': posterUrl,
      'finished': finished
    };
  }
}