import 'package:entertainmentmanager/blocs/register/register_bloc.dart';
import 'package:entertainmentmanager/repositories/auth_repozitory.dart';
import 'package:entertainmentmanager/screens/register/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final AuthRepository _userRepository;

  RegisterScreen({Key key, @required AuthRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}