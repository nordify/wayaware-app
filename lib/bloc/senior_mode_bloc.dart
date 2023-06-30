
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class SeniorModeEvent {
  const SeniorModeEvent();
}

class ModeChange extends SeniorModeEvent {
  const ModeChange(this.value);

  final bool value;
}

class SeniorModeBloc extends Bloc<SeniorModeEvent, bool> {
  SeniorModeBloc(bool startValue) : super(startValue) {
    on<ModeChange>(_onModeChange);
  }


  Future<void> _onModeChange(ModeChange event, Emitter<bool> emit) async {
    return emit(event.value);
  }
  
}