import 'package:entertainmentmanager/repositories/auth_repozitory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'aplication.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/simple_bloc_delegate.dart';

//void main() => runApp(Application());

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final AuthRepository authRepository = AuthRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(authRepository: authRepository)
        ..add(AppStarted()),
      child: Application(authRepository: authRepository),
    ),
  );
}
