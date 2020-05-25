import 'package:entertainmentmanager/model/game.dart';
import 'package:entertainmentmanager/widgets/drawer_menu.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'game_list_item.dart';

class GameScreen extends StatefulWidget {

  String uid;

  GameScreen({Key key, @required this.uid}) : super(key: key);
  @override
  _GameScreen createState() => _GameScreen();
}

class _GameScreen extends State<GameScreen> {

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Query _gameQuery;

  @override
  void initState() {
    _gameQuery = _db.reference().child('db').child('v1').child(widget.uid)
        .child('games')
        .orderByChild('finished');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Game'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: FirebaseAnimatedList(
                  query: _gameQuery,
                  key: ValueKey(_gameQuery),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Game _game = Game.fromSnapshot(snapshot);
                    return GameListItem(uid: widget.uid, game: _game);
                  }
              ),
            )
          ],
        ),
        drawer: DrawerMenu(name: widget.uid)
    );
  }
}