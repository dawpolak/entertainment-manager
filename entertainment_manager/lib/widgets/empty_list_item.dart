import 'package:entertainmentmanager/model/book.dart';
import 'package:entertainmentmanager/screens/book/book_dialog.dart';
import 'package:flutter/material.dart';


class EmptyListItem extends StatelessWidget {



  EmptyListItem();

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
            child: ListTile(
              title: Text("Empty list."),
            ),
          ),
        )
    );
  }
}