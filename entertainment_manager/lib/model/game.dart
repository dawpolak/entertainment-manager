import 'package:firebase_database/firebase_database.dart';

class Game{
  String key;
  String title;
  String platform;
  bool finished;

  Game(this.title, this.platform, {this.finished=false});

  Game.fromSnapshot(DataSnapshot snapshot):
        key = snapshot.key,
        title = snapshot.value['title'],
        platform = snapshot.value['platform'],
        finished = snapshot.value['finished'];

  toJson() {
    return {
      'title': title,
      'platform': platform,
      'finished': finished
    };
  }
}