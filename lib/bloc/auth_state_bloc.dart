import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class AuthStateEvent {
  const AuthStateEvent();
}

class _AuthStateChange extends AuthStateEvent {
  const _AuthStateChange(this.status);

  final AuthState status;
}

class AuthStateBloc extends Bloc<AuthStateEvent, AuthState> {
  AuthStateBloc() : super(AuthState.unkown) {
    on<_AuthStateChange>(_onAuthStateChange);

    FirebaseAuth.instance
        .authStateChanges()
        .listen((user) => add(_AuthStateChange(user != null ? AuthState.authenticated : AuthState.unauthenticated)));
  }

  late final StreamSubscription<User?> _authStateSubscription;

  Future<void> _onAuthStateChange(_AuthStateChange authStateChange, Emitter<AuthState> emit) async {
    emit(authStateChange.status);
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}

enum AuthState {
  authenticated,
  unauthenticated,
  unkown
}