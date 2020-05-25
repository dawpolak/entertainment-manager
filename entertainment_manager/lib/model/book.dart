import 'package:firebase_database/firebase_database.dart';

class Book{
  String key;
  String title;
  String author;
  bool finished;

  Book(this.title, this.author, {this.finished=false});

  Book.fromSnapshot(DataSnapshot snapshot):
        key = snapshot.key,
        title = snapshot.value['title'],
        author = snapshot.value['author'],
        finished = snapshot.value['finished'];

  toJson() {
    return {
      'title': title,
      'author': author,
      'finished': finished
    };
  }
}