import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRepository authRepository;
  AuthenticationCubit(this.authRepository) : super(AuthenticationInitial());

  registerWithEmailPassword(String email, String password) async {
    emit(AuthenticationLoading());
    try {
      UserCredential userCredential =
          await authRepository.registerWithEmailPassword(email, password);
      if (userCredential == null) {
        emit(AuthenticationError());
      } else {
        emit(AuthenticationSucess(userCredential));
      }
    } catch (ex) {
      emit(AuthenticationError());
    }
  }

  loginWithEmailPassword(String email, String password) async {
    emit(AuthenticationLoading());
    try {
      UserCredential userCredential =
          await authRepository.registerWithEmailPassword(email, password);
      if (userCredential == null) {
        emit(AuthenticationError());
      } else {
        emit(AuthenticationSucess(userCredential));
      }
    } catch (ex) {
      emit(AuthenticationError());
    }
  }
}
