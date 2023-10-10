import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_comics/src/data/data.dart';
import 'package:marvel_comics/src/data/models/response/caraceter_model.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CharacterDatasource remoteDatasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    remoteDatasource = CharacterDatasource(mockDio);
  });

  group(
    'getCharacterModel',
    () {
      test(
        'getCharacters should return a list of CharacterModel',
        () async {
          final dioResponse = Response<Map<String, dynamic>>(
            data: {
              'data': {
                'results': [
                  {
                    'id': 1,
                    'name': 'Character Name',
                    'description': 'Character Description',
                    'thumbnail': {
                      'path': 'path/to/thumbnail',
                      'extension': 'jpg',
                    },
                    'comics': {
                      'items': [
                        {
                          'name': 'Comic 1',
                        },
                        {
                          'name': 'Comic 2',
                        },
                      ],
                    },
                  },
                ],
              },
            },
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          );

          // Arrange
          when(() => mockDio.get(any())).thenAnswer((_) async => dioResponse);

          // Act
          final result = await remoteDatasource.getCharacters(0);

          // Assert
          expect(result, isNotEmpty);
          expect(result, isA<List<CharacterModel>>());
        },
      );
      test(
        'should return an error when making the call',
        () async {
          // Arrange
          when(() => mockDio.get(any())).thenThrow(Exception());

          // Act
          final result = remoteDatasource.getCharacters(0);

          // Assert
          expect(result, throwsA(isA<Exception>()));
        },
      );
    },
  );
}
