import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayaware_app/bloc/auth_state_bloc.dart';

sealed class AuthUserEvent {
  const AuthUserEvent();
}

class _AuthUserChange extends AuthUserEvent {
  const _AuthUserChange(this.user);

  final User? user;
}

class AuthUserBloc extends Bloc<AuthUserEvent, User?> {
  AuthUserBloc(this._authStateBloc) : super(null) {
    on<_AuthUserChange>(_onAuthUserChange);

    _authStateBlocSubscription = _authStateBloc.stream.
      listen((state) => add(_AuthUserChange(FirebaseAuth.instance.currentUser)));
  }

  final AuthStateBloc _authStateBloc;
  late final StreamSubscription<AuthState> _authStateBlocSubscription;

  Future<void> _onAuthUserChange(_AuthUserChange authUserChange, Emitter<User?> emit) async {
    emit(authUserChange.user);
  }

  @override
  Future<void> close() {
    _authStateBlocSubscription.cancel();
    return super.close();
  }
}
