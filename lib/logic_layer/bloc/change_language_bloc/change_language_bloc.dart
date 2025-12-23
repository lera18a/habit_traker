import 'package:bloc/bloc.dart';
part 'change_language_event.dart';
part 'change_language_state.dart';

class ChangeLanguageBloc
    extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc() : super(ChangeLanguageState(languageToggle: false)) {
    on<ChangeLanguageEvent>(_onChangeLanguageEvent);
  }
  Future<void> _onChangeLanguageEvent(
    ChangeLanguageEvent event,
    Emitter<ChangeLanguageState> emit,
  ) async {
    final finalState = !state.languageToggle;
    emit(ChangeLanguageState(languageToggle: finalState));
  }
}
