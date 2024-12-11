import 'dart:io';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import 'store_home_state.dart';

class HomeViewModel extends ViewModel<HomeState> {
  final IGetCharacterUsecase _getCharacterUsecase;

  HomeViewModel(this._getCharacterUsecase) : super(HomeState.initial());

  @override
  void initViewModel() {
    super.initViewModel();
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      showCharacter();
    }
  }

  Future<void> showCharacter() async {
    emit(state.copyWith(loading: true, error: false));

    final response = await _getCharacterUsecase(state.page);

    var newState = response.fold(
      (error) => state.copyWith(error: true),
      (characters) {
        final ids = <int>{};
        final newCharacters = [...state.characters, ...characters]
          ..retainWhere((e) => ids.add(e.id));
        return state.copyWith(characters: newCharacters);
      },
    );

    emit(newState.copyWith(loading: false));
  }

  void chagePage() => emit(state.copyWith(page: state.page + 20));
}
