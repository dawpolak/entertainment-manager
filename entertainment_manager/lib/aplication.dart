import 'dart:developer';

import 'package:entertainmentmanager/repositories/auth_repozitory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'screens/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/splash_screen.dart';

class Application extends StatelessWidget {
  final AuthRepository _authRepository;

  Application({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        primaryColor: Colors.orange[300],
        accentColor: Colors.red

      ),
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(authRepository: _authRepository);
          }
          if (state is Authenticated) {

            return HomeScreen(uid: state.displayUID);
            //return HomeScreen();
          }
          return SplashScreen();
        },
      ),
    );
  }
}

//// TODO: Convert ShrineApp to stateful widget (104)
//class Application extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Entertainment manager',
//      // TODO: Change home: to a Backdrop with a HomePage frontLayer (104)
//      home: HomePage(),
//      // TODO: Make currentCategory field take _currentCategory (104)
//      // TODO: Pass _currentCategory for frontLayer (104)
//      // TODO: Change backLayer field value to CategoryMenuPage (104)
//      initialRoute: '/login',
//      onGenerateRoute: _getRoute,
//      // TODO: Add a theme (103)
//    );
//  }
//
//  Route<dynamic> _getRoute(RouteSettings settings) {
//    if (settings.name != '/login') {
//      return null;
//    }
//
//    return MaterialPageRoute<void>(
//      settings: settings,
//      builder: (BuildContext context) => LoginPage(),
//      fullscreenDialog: true,
//    );
//  }
//}

// TODO: Build a Shrine Theme (103)
// TODO: Build a Shrine Text Theme (103)