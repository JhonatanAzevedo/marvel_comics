import 'package:equatable/equatable.dart';
import 'package:marvel_comics/src/domain/domain.dart';
import '../../../core/core.dart';

class HomeState extends ViewModelState with EquatableMixin {
  factory HomeState.initial() => const HomeState();

  const HomeState({
    this.loading = false,
    this.characters = const [],
    this.page = 0,
    this.error = false,
  });

  final bool loading;
  final int page;
  final bool error;
  final List<Character> characters;

  HomeState copyWith({
    bool? loading,
    int? page,
    bool? error,
    List<Character>? characters,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      page: page ?? this.page,
      error: error ?? this.error,
      characters: characters ?? this.characters,
    );
  }

  @override
  List<Object?> get props => [loading, page, error, characters];
}
