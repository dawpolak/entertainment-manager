import 'package:entertainmentmanager/repositories/auth_repozitory.dart';
import 'package:entertainmentmanager/repositories/rldb_repository.dart';
import 'package:entertainmentmanager/screens/series/series_dialog.dart';
import 'package:entertainmentmanager/screens/series/series_screen.dart';
import 'package:flutter/material.dart';
import 'book/book_dialog.dart';
import 'book/book_screen.dart';
import 'game/game_dialog.dart';
import 'game/game_screen.dart';
import 'movie/movie_dialog.dart';
import 'movie/movie_screen.dart';


class HomeScreen extends StatefulWidget {
  final String uid;

  HomeScreen({Key key, @required this.uid}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {

//  final List<Widget> screens = [
//    MovieScreen(),
//    SeriesScreen(),
//    GameScreen(),
//    BookScreen(),
//  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  int currentTab = 0;
  Widget currentScreen;


  createAlertDialog(BuildContext context, int currentTab) {

    return showDialog(context: context, builder: (context){
      return getDialog(currentTab);
    });
  }

  getDialog(int tabIndex){
    switch(tabIndex){
      case 0:
      return MovieDialog(uid: widget.uid, editMode: false,);
        break;
      case 1:
        return SeriesDialog(uid:widget.uid, editMode: false,);
        break;
      case 2:
        return GameDialog(uid:widget.uid, editMode: false,);
        break;
      case 3:
        return BookDialog(uid: widget.uid, editMode: false,);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
            createAlertDialog(context, currentTab);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            MovieScreen(uid: widget.uid); // if user taps on this dashboard tab will be active
                        print(widget.uid);
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.local_movies,
                          color: currentTab == 0 ? Colors.red : Colors.grey,
                        ),
                        Text(
                          'Movie',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            SeriesScreen(uid: widget.uid); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.movie_filter,
                          color: currentTab == 1 ? Colors.red : Colors.grey,
                        ),
                        Text(
                          'Series',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            GameScreen(uid: widget.uid); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.videogame_asset,
                          color: currentTab == 2 ? Colors.red : Colors.grey,
                        ),
                        Text(
                          'Game',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            BookScreen(uid: widget.uid,); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.book,
                          color: currentTab == 3 ? Colors.red : Colors.grey,
                        ),
                        Text(
                          'Book',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    currentScreen = MovieScreen(uid: widget.uid);
    super.initState();
  }
}
