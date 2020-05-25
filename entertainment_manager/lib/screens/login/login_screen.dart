import 'package:entertainmentmanager/blocs/login/login_bloc.dart';
import 'package:entertainmentmanager/repositories/auth_repozitory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../gradient_container.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final AuthRepository _userRepository;

  LoginScreen({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _userRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        GradientContainer(
          color: Colors.orange,
          child: BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(userRepository: _userRepository),
            child: LoginForm(userRepository: _userRepository),
          )
        ),
    );
  }
}