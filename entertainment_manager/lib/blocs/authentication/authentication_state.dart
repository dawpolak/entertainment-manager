part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String displayName;
  final String displayUID;


  const Authenticated(this.displayUID,this.displayName);

  @override
  List<Object> get props => [displayUID, displayName];

  @override
  String toString() => 'Authenticated { UID: $displayUID, email: $displayName }';
}

class Unauthenticated extends AuthenticationState {}