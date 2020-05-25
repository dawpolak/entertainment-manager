import 'package:entertainmentmanager/model/book.dart';
import 'package:entertainmentmanager/repositories/rldb_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomDialog extends StatefulWidget {

  GlobalKey<ScaffoldState> snackKey;
  String uid;
  bool editMode;
  Book book;

  CustomDialog({this.uid, this.editMode, this.book});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

  RldbRepository _db = RldbRepository();
  final _formKey = GlobalKey<FormState>();

  String author = '';
  String title = '';
  bool finished = false;

  void initState() {
    if (widget.book != null) {
      Book _book = widget.book;
      author = _book.author;
      title = _book.title;
      finished = _book.finished;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(),
    );
  }

  dialogContent() {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              widget.editMode ? Text('Edit book',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),) : Text('Add book',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),),

              Form(
                key: _formKey,
                child:
                  Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val) => val.isNotEmpty ? null : 'Title cannot be empty.',
                        initialValue: title,
                        onChanged: (val){
                          setState(() => title = val);
                        },
                        decoration: InputDecoration(
                            hintText: 'Title'
                        ),
                      ),
                      TextFormField(
                        validator: (val) => val.isNotEmpty ? null : 'Author cannot be empty.',
                        initialValue: author,
                        onChanged: (val){
                          setState(() => author = val);
                        },
                        decoration: InputDecoration(
                            hintText: 'Author'
                        ),
                      ),
                      CheckboxListTile(
                        title: Text('Finished:'),
                        value: finished,
                        onChanged: (bool newValue) {
                          setState(() {
                            finished = newValue;
                          });
                        },
                      ),
                    ],
                  ),

              ),
              SizedBox(height: 12.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child:
                      Align(

                        alignment: Alignment.bottomLeft,
                        child: MaterialButton(
                            child: widget.editMode ? Icon(Icons.delete_outline) : null,
                            onPressed: () async {
                              if (widget.editMode){
                                await _db.deleteBook(widget.uid,widget.book);
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "Deleted",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.orange[300],
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            }
                        ),
                      ),
                  ),
                  Expanded(
                    child:
                      Align(
                        alignment: Alignment.bottomRight,
                        child: MaterialButton(
                          elevation: 5.0,
                          child: Text('Submit'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()){
                              Book _book = Book(title, author, finished: finished);
                              if (!widget.editMode) {
                                await _db.addBook(widget.uid,_book);
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "Added",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.orange[300],
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              } else{
                                _book.key = widget.book.key;
                                await _db.editBook(widget.uid,_book);
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "Edited",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.orange[300],
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            }
                          },
                        ),
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: Consts.avatarRadius,
          ),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 16.0;
}