import 'package:entertainmentmanager/model/book.dart';
import 'package:entertainmentmanager/screens/book/book_dialog.dart';
import 'package:flutter/material.dart';


class BookListItem extends StatelessWidget {

  String uid;
  Book book;

  BookListItem({this.uid, this.book,});

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
                return BookDialog(uid: uid, editMode: true, book: book,);
              });
            },
            child: ListTile(
              leading: Icon(Icons.book),
              title: Text(book.title),
              subtitle: Text(book.author),
              trailing: book.finished ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
            ),
          ),
        )
    );
  }
}