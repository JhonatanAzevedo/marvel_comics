import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_comics/src/data/data.dart';
import 'package:marvel_comics/src/data/models/response/caraceter_model.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRemoteDataSource extends Mock implements ICharacterDatasource {}

void main() {
  late MockHomeRemoteDataSource mockRemoteDataSource;
  late CharacterRepository repository;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = CharacterRepository(mockRemoteDataSource);
  });

  group(
    'getGuideExecutions',
    () {
      final testCharacterModel = [
        CharacterModel(
          id: 1212,
          description: 'description',
          name: 'name',
          thumbnail: 'thumbnail',
          comics: [],
        ),
      ];

      test('should return a list of characters', () async {
        // Arrange
        when(() => mockRemoteDataSource.getCharacters(0)).thenAnswer((_) async => testCharacterModel);

        // Act
        final result = await repository.getCharacters(0);

        // Assert
        expect(result.isRight(), true);
      });

      test(
        'should return Left(Failure) getCharacters',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.getCharacters(0)).thenThrow(TestFailure(''));

          // Act
          final result = await repository.getCharacters(0);

          // Assert
          expect(result.isLeft(), true);
        },
      );
    },
  );
}
