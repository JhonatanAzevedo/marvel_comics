import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_comics/src/domain/domain.dart';
import 'package:marvel_comics/src/domain/entities/comic.dart';
import 'package:marvel_comics/src/presentation/views/home/home_viewmodel.dart';
import 'package:marvel_comics/src/presentation/views/home/store_home_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCharacterUsecase extends Mock implements IGetCharacterUsecase {}

void main() {
  late MockGetCharacterUsecase mockGetCharacterUsecase;
  late HomeViewModel homeViewModel;

  setUpAll(() {
    registerFallbackValue(0);
  });

  setUp(() {
    mockGetCharacterUsecase = MockGetCharacterUsecase();
    homeViewModel = HomeViewModel(mockGetCharacterUsecase);
  });

  group(
    'HomeViewModel Tests',
    () {
      final mockCharacters = [
        const Character(
          id: 33,
          name: 'Character',
          description: 'tetse',
          thumbnail: 'teste',
          comics: [
            Comic(name: 'teste'),
          ],
        ),
      ];

      blocTest<HomeViewModel, HomeState>(
        'emits [loading: true, characters: mockCharacters, loading: false]'
        ' when showCharacter is called successfully',
        build: () {
          when(() => mockGetCharacterUsecase(any())).thenAnswer(
            (_) async => Right(mockCharacters),
          );
          return HomeViewModel(mockGetCharacterUsecase);
        },
        act: (viewModel) => viewModel.showCharacter(),
        expect: () => [
          const HomeState(loading: true, error: false),
          HomeState(
            characters: mockCharacters,
            loading: false,
          ),
        ],
      );

      blocTest<HomeViewModel, HomeState>(
        'emits [loading: true, error: true, loading: false] when showCharacter fails',
        build: () {
          when(() => mockGetCharacterUsecase(any())).thenAnswer(
            (_) async => const Left(CharacterFailure()),
          );
          return homeViewModel;
        },
        act: (viewModel) => viewModel.showCharacter(),
        expect: () => [
          HomeState.initial().copyWith(loading: true, error: false),
          HomeState.initial().copyWith(error: true, loading: false),
        ],
      );

      blocTest<HomeViewModel, HomeState>(
        'emits updated page when changePage is called',
        build: () => homeViewModel,
        act: (viewModel) => viewModel.chagePage(),
        expect: () => [
          HomeState.initial().copyWith(page: 20),
        ],
      );
    },
  );
}
