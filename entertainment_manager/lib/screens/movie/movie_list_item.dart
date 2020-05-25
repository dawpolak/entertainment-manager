import 'package:entertainmentmanager/model/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'movie_dialog.dart';


class MovieListItem extends StatelessWidget {

  String uid;
  Movie movie;

  MovieListItem({this.uid, this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.3, 0.7, 1],
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
              return MovieDialog(uid: uid, editMode: true, movie: movie,);
            });
          },
          child: Row(
            children: <Widget>[

              posterWidget(movie.posterUrl),
              Flexible(child:ListTile(
                //leading: posterWidget(movie.posterUrl),
                title: Text(movie.title),
                subtitle: Text(movie.year),
                trailing: movie.finished ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
              ),
              )
            ],)
      ),
    ),
    );
  }

  posterWidget(String posterUrl){
    if(posterUrl != null){
      return Container(
        child:Image.network(posterUrl),
        height: 150,
        width: 100,
      );
    }
    return Container(
      child:Icon(Icons.local_movies),
      width: 100,
      height: 150,
      color: Colors.grey,
    );
  }
}