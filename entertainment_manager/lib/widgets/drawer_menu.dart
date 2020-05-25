import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:entertainmentmanager/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DrawerMenu extends StatelessWidget
{
  final String name;

  DrawerMenu({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.7, 1],
            colors: [
              Colors.orange[50],
              Colors.orange[200],
              Colors.orange[300],
            ],
          ),
        ),
        child:
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                ),
                child: Image.asset('assets/entertainment_manager_logo.png', scale: 0.8),
              ),
//              Padding(
//                  padding: EdgeInsets.all(10.0),
//                  child: Text('User: $name',
//                    style: TextStyle(
//                      color: Colors.orange,
//                      fontSize: 16,
//                    ),
//                  )
//              ),
              ListTile(
                leading: Icon(Icons.perm_device_information),
                title: Text('About',
                    style: TextStyle(fontSize: 16)),
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "[Future] navigate to informations about application",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.orange[300],
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Help',
                    style: TextStyle(fontSize: 16)),
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "[Future] navigate to remote website of our company",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.orange[300],
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout',
                style: TextStyle(fontSize: 16)),
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    LoggedOut(),
                  );
                },
              )
            ],
          ),
      ),
    );
  }
}
