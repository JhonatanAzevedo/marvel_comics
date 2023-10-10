import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_comics/src/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements ICharacterRepository {}

void main() {
  late GetCharacterUsecase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetCharacterUsecase(mockRepository);
  });

  const testResponse = [
    Character(
      id: 1212,
      description: 'description',
      name: 'name',
      thumbnail: 'thumbnail',
      comics: [],
    ),
  ];

  test(
    'should return the result from the repository',
    () async {
      // Arrange
      when(() => mockRepository.getCharacters(0)).thenAnswer((_) async => const Right(testResponse));

      // Act
      final result = await usecase(0);

      // Assert
      expect(result, const Right(testResponse));
    },
  );

  test(
    'should return a failure from the repository',
    () async {
      // Arrange
      when(() => mockRepository.getCharacters(0)).thenAnswer((_) async => const Left(CharacterFailure()));

      // Act
      final result = await usecase(0);

      // Assert
      expect(result.isLeft(), true);
    },
  );
}
