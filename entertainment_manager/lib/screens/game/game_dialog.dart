import 'package:entertainmentmanager/model/game.dart';
import 'package:entertainmentmanager/repositories/rldb_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GameDialog extends StatefulWidget {

  String uid;
  bool editMode;
  Game game;

  GameDialog({this.uid, this.editMode, this.game});

  @override
  _GameDialogState createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {

  RldbRepository _db = RldbRepository();
  final _formKey = GlobalKey<FormState>();

  String _dropdownPlatform = "PC";
  String title = '';
  bool finished = false;

  @override
  void initState() {
    if (widget.game != null){
      Game _game = widget.game;
      _dropdownPlatform = _game.platform;
      title = _game.title;
      finished = _game.finished;
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
              widget.editMode ? Text('Edit game',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),) : Text('Add game',
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
                    DropdownButton<String>(
                      value: _dropdownPlatform,
                      onChanged: (String newValue) {
                        setState(() {
                          _dropdownPlatform = newValue;
                        });
                      },
                      items: <String>['PC', 'PS4', 'XONE', 'Switch', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    CheckboxListTile(
                      title: Text('Finished:'),
                      value: finished,
                      onChanged: (bool newValue) {
                        setState(() {
                          finished = newValue;
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
                              content: Text("Do you really want to delete this game?"),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text("YES"),
                                    onPressed: ()
                                    async {
                                      if (widget.editMode){
                                        await _db.deleteGame(widget.uid, widget.game);
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
                      ) : null,
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
                            Game _game = Game(title, _dropdownPlatform, finished: finished);
                            if (!widget.editMode) {
                              await _db.addGame(widget.uid,_game);
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
                              _game.key = widget.game.key;
                              await _db.editGame(widget.uid,_game);
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