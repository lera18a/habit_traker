import 'package:bloc/bloc.dart';

part 'change_theme_event.dart';
part 'change_theme_state.dart';

class ChangeThemeBloc extends Bloc<ChangeThemeEvent, ChangeThemeState> {
  ChangeThemeBloc() : super(ChangeThemeState(themeToggle: false)) {
    on<ChangeThemeEvent>(_onChangeThemeEvent);
  }
  Future<void> _onChangeThemeEvent(
    ChangeThemeEvent event,
    Emitter<ChangeThemeState> emit,
  ) async {
    final finalState = !state.themeToggle;
    emit(ChangeThemeState(themeToggle: finalState));
  }
}
