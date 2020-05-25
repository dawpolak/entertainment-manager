import 'dart:developer';

import 'package:entertainmentmanager/model/book.dart';
import 'package:entertainmentmanager/screens/book/book_list_item.dart';
import 'package:entertainmentmanager/widgets/drawer_menu.dart';
import 'package:entertainmentmanager/widgets/empty_list_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  final String uid;

  BookScreen({Key key, @required this.uid,}) : super(key: key);
  @override
  _BookScreen createState() => _BookScreen();
}

class _BookScreen extends State<BookScreen> {

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Query _bookQuery;

  @override
  void initState() {
    _bookQuery = _db.reference().child('db').child('v1').child(widget.uid)
        .child('books')
        .orderByChild('finished');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Book'),
      ),
        body:Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: FirebaseAnimatedList(
                      query: _bookQuery,
                      key: ValueKey(_bookQuery),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index){
                        Book _book = Book.fromSnapshot(snapshot);
                        return BookListItem(uid: widget.uid ,book: _book);
                      },
                  ),
                )
              ],
            )
        ),
        drawer: DrawerMenu(name: widget.uid)
    );
  }
}