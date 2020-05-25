import 'package:entertainmentmanager/model/movie.dart';
import 'package:entertainmentmanager/screens/series/series_list_item.dart';
import 'package:entertainmentmanager/widgets/drawer_menu.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class SeriesScreen extends StatefulWidget {
  final String uid;

  SeriesScreen({Key key, @required this.uid, }) : super(key: key);

  @override
  _SeriesScreen createState() => _SeriesScreen();
}

class _SeriesScreen extends State<SeriesScreen> {

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Query _movieQuery;

  @override
  void initState() {
    _movieQuery = _db.reference().child('db').child('v1').child(widget.uid)
        .child('series')
        .orderByChild('finished');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Series'),
          actions: <Widget>[
//            IconButton(
//                onPressed: (){},
//                icon: Icon(Icons.search)
//            )
          ],
        ),
        body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: FirebaseAnimatedList(
                      query: _movieQuery,
                      key: ValueKey(_movieQuery),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index){
                        Movie _movie = Movie.fromSnapshot(snapshot);
                        return SeriesListItem(uid: widget.uid, movie: _movie);
                      }
                  ),
                )
              ],
            )
        ),

        drawer: DrawerMenu(name: widget.uid)
    );
  }
}

