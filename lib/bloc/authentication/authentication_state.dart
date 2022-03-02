part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSucess extends AuthenticationState {
  final UserCredential userCredential;
  AuthenticationSucess(this.userCredential);
  @override
  List<Object> get props => [userCredential];
}

class AuthenticationError extends AuthenticationState {
  @override
  List<Object> get props => [];
}
