import 'package:entertainmentmanager/model/movie.dart';
import 'package:entertainmentmanager/repositories/api_movie_repository.dart';
import 'package:entertainmentmanager/repositories/rldb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SeriesDialog extends StatefulWidget {

  String uid;
  bool editMode;
  Movie series;

  SeriesDialog({this.uid, this.editMode, this.series});

  @override
  _SeriesDialogState createState() => _SeriesDialogState();
}

class _SeriesDialogState extends State<SeriesDialog> {

  RldbRepository _db = RldbRepository();
  ApiMovieService _api = ApiMovieService();
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final yearController = TextEditingController();

  String _title = '';
  String _year = '';
  String _posterUrl;
  bool _finished = false;

  @override
  void initState() {
    if (widget.series != null){
      Movie _series = widget.series;
      _title = _series.title;
      titleController.text = _title;
      _year = _series.year;
      yearController.text = _year;
      _finished = _series.finished;
      _posterUrl = _series.posterUrl;
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
              widget.editMode ? Text('Edit series',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),) : Text('Add series',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),),

              Form(
                key: _formKey,
                child:
                Column(
                  children: <Widget>[
                    TypeAheadFormField(
                      validator: (val) => val.isNotEmpty ? null : 'Title cannot be empty.',
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: titleController,
                        decoration: InputDecoration(
                            hintText: 'Title'
                        ),
                      ),
                      suggestionsCallback: (titlePattern) async {
                        return await _api.fetchMovieSuggestions(titlePattern, type:'series');
                      },
                      itemBuilder: (context, suggestion){
                        return ListTile(
                          leading: Image.network(suggestion['Poster']),
                          title: Text(suggestion['Title']),
                          subtitle: Text(suggestion['Year']),
                        );
                      },
                      onSuggestionSelected: (suggestion){
                        setState(() {
                          titleController.text = suggestion['Title'];
                          yearController.text = suggestion['Year'];
                          _title = suggestion['Title'];
                          _year = suggestion['Year'];
                          _posterUrl = suggestion['Poster'];
                        });
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: yearController,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      onChanged: (val){
                        setState(() {
                          _year = val;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'Year'
                      ),
                    ),
                    CheckboxListTile(
                      title: Text('Finished:'),
                      value: _finished,
                      onChanged: (bool newValue) {
                        setState(() {
                          _finished = newValue;
                        });
                      },
                    )
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
                      child: widget.editMode ? MaterialButton(
                          child: widget.editMode ? Icon(Icons.delete) : null,
                          onPressed: (){
                            return showDialog(context: context, builder: (context){ return AlertDialog(
                              title: Text('Confirm delete'),
                              content: Text("Do you really want to delete this series?"),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text("YES"),
                                    onPressed: ()
                                    async {
                                      if (widget.editMode){
                                        await _db.deleteMovie(widget.uid, widget.series, isSeries: true);
                                        Navigator.pop(context);
                                        Navigator.of(context).pop();
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

                                FlatButton(
                                  child: Text("NO"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),

                              ],
                            );
                            });

                          }
                      ): null,
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
                            _title = titleController.text;
                            Movie series = Movie(title: _title, year:_year, posterUrl: _posterUrl, finished: _finished);
                            if (!widget.editMode) {
                              await _db.addMovie(widget.uid,series,isSeries: true);
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
                              series.key = widget.series.key;
                              await _db.editMovie(widget.uid,series, isSeries: true);
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

//  @override
//  Widget build(BuildContext context) {
//    return AlertDialog(
//      title: widget.editMode ? Text('Edit series') : Text('Add series'),
//      content: Form(
//        key: _formKey,
//        child: Column(
//          children: <Widget>[
//            TypeAheadFormField(
//              validator: (val) => val.isNotEmpty ? null : 'Title cannot be empty.',
//              textFieldConfiguration: TextFieldConfiguration(
//                controller: titleController,
//                decoration: InputDecoration(
//                    hintText: 'Title'
//                ),
//              ),
//              suggestionsCallback: (titlePattern) async {
//                return await _api.fetchMovieSuggestions(titlePattern, type:'series');
//              },
//              itemBuilder: (context, suggestion){
//                return ListTile(
//                  leading: Image.network(suggestion['Poster']),
//                  title: Text(suggestion['Title']),
//                  subtitle: Text(suggestion['Year']),
//                );
//              },
//              onSuggestionSelected: (suggestion){
//                setState(() {
//                  titleController.text = suggestion['Title'];
//                  yearController.text = suggestion['Year'];
//                  _title = suggestion['Title'];
//                  _year = suggestion['Year'];
//                  _posterUrl = suggestion['Poster'];
//                });
//              },
//            ),
//            TextFormField(
//              keyboardType: TextInputType.number,
//              controller: yearController,
//              inputFormatters: <TextInputFormatter>[
//                WhitelistingTextInputFormatter.digitsOnly
//              ],
//              onChanged: (val){
//                setState(() {
//                  _year = val;
//                });
//              },
//              decoration: InputDecoration(
//                  hintText: 'Year'
//              ),
//            ),
//            posterWidget(),
//            CheckboxListTile(
//              title: Text('Finished:'),
//              value: _finished,
//              onChanged: (bool newValue) {
//                setState(() {
//                  _finished = newValue;
//                });
//              },
//            )
//          ],
//        ),
//      ),
//      actions: <Widget>[
//        MaterialButton(
//            child: widget.editMode ? Icon(Icons.delete) : null,
//            onPressed: () async {
//              if (widget.editMode){
//                await _db.deleteMovie(widget.uid, widget.series, isSeries: true);
//                Navigator.pop(context);
//                Fluttertoast.showToast(
//                    msg: "Deleted",
//                    toastLength: Toast.LENGTH_SHORT,
//                    gravity: ToastGravity.CENTER,
//                    timeInSecForIosWeb: 1,
//                    backgroundColor: Colors.orange[300],
//                    textColor: Colors.white,
//                    fontSize: 16.0
//                );
//              }
//            }
//        ),
//        SizedBox(width: 120.0,),
//        MaterialButton(
//          elevation: 5.0,
//          child: Text('Submit'),
//          onPressed: () async {
//            if (_formKey.currentState.validate()){
//              _title = titleController.text;
//              Movie series = Movie(title: _title, year:_year, posterUrl: _posterUrl, finished: _finished);
//              if (!widget.editMode) {
//                await _db.addMovie(widget.uid,series,isSeries: true);
//                Navigator.pop(context);
//                Fluttertoast.showToast(
//                    msg: "Added",
//                    toastLength: Toast.LENGTH_SHORT,
//                    gravity: ToastGravity.CENTER,
//                    timeInSecForIosWeb: 1,
//                    backgroundColor: Colors.orange[300],
//                    textColor: Colors.white,
//                    fontSize: 16.0
//                );
//              } else{
//                series.key = widget.series.key;
//                await _db.editMovie(widget.uid,series, isSeries: true);
//                Navigator.pop(context);
//                Fluttertoast.showToast(
//                    msg: "Edited",
//                    toastLength: Toast.LENGTH_SHORT,
//                    gravity: ToastGravity.CENTER,
//                    timeInSecForIosWeb: 1,
//                    backgroundColor: Colors.orange[300],
//                    textColor: Colors.white,
//                    fontSize: 16.0
//                );
//              }
//            }
//          },
//        ),
//      ],
//    );
//  }



//  posterWidget(){
//    if(_posterUrl != null){
//      return Container(
//        child:Image.network(_posterUrl),
//        height: 150,
//        width: 100,
//        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
//      );
//    }
//    return Container(
//      child:Icon(Icons.local_movies),
//      width: 100,
//      height: 150,
//      color: Colors.grey,
//      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
//    );
//  }
