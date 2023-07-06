import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class SettingsChangeEvent {
  const SettingsChangeEvent();
}

class _StreamChange extends SettingsChangeEvent {
  const _StreamChange(this.value);

  final Map<String, bool> value;
}

class LocalChange extends SettingsChangeEvent {
  const LocalChange(this.value);

  final Map<String, bool> value;
}

class UserSettingsBloc extends Bloc<SettingsChangeEvent, Map<String, bool>> {
  UserSettingsBloc(this._user) : super({}) {
    on<_StreamChange>(_onStreamModeChange);
    on<LocalChange>(_onModeChange);

    _accessibilityModeSubscription = FirebaseFirestore.instance
        .collection('settings')
        .doc(_user.uid)
        .snapshots()
        .listen((event) {
      if (event.data() == null) return;
      if (event.data()!.isEmpty) return;

      Map<String, bool> streamMap = {};
      event.data()!.forEach((key, value) {
        if (value is bool) {
          streamMap[key] = value;
        }
      });

      add(_StreamChange(streamMap));
    });
  }

  final User _user;
  late final StreamSubscription _accessibilityModeSubscription;

  Future<void> _onStreamModeChange(
      _StreamChange event, Emitter<Map<String, bool>> emit) async {
    final updateMap = state;
    updateMap.addAll(event.value);

    emit({});
    return emit(updateMap);
  }

  Future<void> _onModeChange(
      LocalChange event, Emitter<Map<String, bool>> emit) async {
    final data = await FirebaseFirestore.instance
        .collection('settings')
        .doc(_user.uid)
        .get();

    if (data.exists) {
      FirebaseFirestore.instance
          .collection('settings')
          .doc(_user.uid)
          .update(event.value);
    } else {
      FirebaseFirestore.instance
          .collection('settings')
          .doc(_user.uid)
          .set(event.value);
    }

    final updateMap = state;
    updateMap.addAll(event.value);

    emit({});
    return emit(updateMap);
  }

  @override
  Future<void> close() {
    _accessibilityModeSubscription.cancel();
    return super.close();
  }
}
