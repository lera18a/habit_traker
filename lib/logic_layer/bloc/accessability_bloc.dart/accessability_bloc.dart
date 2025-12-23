import 'package:bloc/bloc.dart';

part 'accessability_event.dart';
part 'accessability_state.dart';

class AccessabilityBloc
    extends Bloc<AccessabilityNewEvent, AccessabilityNewState> {
  AccessabilityBloc()
    : super(AccessabilityNewState(accessabilityToggle: false)) {
    on<AccessabilityNewEvent>(_onAccessabilityNewEvent);
  }

  Future<void> _onAccessabilityNewEvent(
    AccessabilityNewEvent event,
    Emitter<AccessabilityNewState> emit,
  ) async {
    final finalState = !state.accessabilityToggle;
    emit(AccessabilityNewState(accessabilityToggle: finalState));
  }
}
