import 'package:entertainmentmanager/model/game.dart';
import 'package:flutter/material.dart';

import 'game_dialog.dart';

class GameListItem extends StatelessWidget {

  String uid;
  Game game;

  GameListItem({this.uid, this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.05, 0.15, 1],
              colors: [
                Colors.grey[300],
                Colors.grey[200],
                Colors.grey[100],
              ],
            ),
          ),
          child: InkWell(
            onTap: (){
              showDialog(context: context, builder: (context){
                return GameDialog(uid: uid, editMode: true, game: game,);
              });
            },
            child: ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text(game.title),
              subtitle: Text(game.platform),
              trailing: game.finished ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
            ),
          ),
        )
    );
  }
}