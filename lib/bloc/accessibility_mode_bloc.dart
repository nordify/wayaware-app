import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class AccessibilityModeEvent {
  const AccessibilityModeEvent();
}

class _StreamModeChange extends AccessibilityModeEvent {
  const _StreamModeChange(this.value);

  final bool value;
}

class ModeChange extends AccessibilityModeEvent {
  const ModeChange(this.value);

  final bool value;
}

class AccessibilityModeBloc extends Bloc<AccessibilityModeEvent, bool> {
  AccessibilityModeBloc(this._user) : super(false) {
    on<_StreamModeChange>(_onStreamModeChange);
    on<ModeChange>(_onModeChange);

    _accessibilityModeSubscription = FirebaseFirestore.instance.collection('settings').doc(_user.uid).snapshots().listen((event) {
      if (event.data() == null) return;
      if (event.data()!.isEmpty) return;
      if (event.data()!['accessibility_mode'] == null) return;

      add(_StreamModeChange(event.data()!['accessibility_mode']));
    });
  }

  final User _user;
  late final StreamSubscription _accessibilityModeSubscription;

  Future<void> _onStreamModeChange(_StreamModeChange event, Emitter<bool> emit) async {
    return emit(event.value);
  }

  Future<void> _onModeChange(ModeChange event, Emitter<bool> emit) async {
    FirebaseFirestore.instance.collection('settings').doc(_user.uid).set({'accessibility_mode': event.value});

    return emit(event.value);
  }

  @override
  Future<void> close() {
    _accessibilityModeSubscription.cancel();
    return super.close();
  }
}
