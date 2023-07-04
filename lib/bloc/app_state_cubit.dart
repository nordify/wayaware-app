import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayaware/bloc/auth_state_bloc.dart';

class AppStateCubit extends Cubit<AppState> with ChangeNotifier {
  AppStateCubit(this._authStateBloc) : super(AppState.unkown) {
    if (_authStateBloc.state == AuthState.authenticated) {
      _streamChangeAppState(AuthState.authenticated);
    }

    _authStateBlocSubscription = _authStateBloc.stream.listen((state) => _streamChangeAppState(state));
  }

  final AuthStateBloc _authStateBloc;
  late final StreamSubscription<AuthState> _authStateBlocSubscription;

  void _streamChangeAppState(AuthState authState) {
    switch (authState) {
      case AuthState.authenticated:
        emit(AppState.authenticated);
        break;
      case AuthState.unauthenticated:
        emit(AppState.unauthenticated);
        break;
      case AuthState.unkown:
        emit(AppState.unkown);
        break;
    }
    notifyListeners();
  }

  void changeAppState(AppState state) {
    emit(state);
    notifyListeners();
  }

  @override
  Future<void> close() {
    _authStateBlocSubscription.cancel();
    return super.close();
  }
}

enum AppState { authenticated, unauthenticated, unkown }
