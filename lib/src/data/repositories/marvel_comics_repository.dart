import 'package:dartz/dartz.dart';

import '../../domain/domain.dart';
import '../data.dart';

class CharacterRepository implements ICharacterRepository {
  final ICharacterDatasource _datasource;

  CharacterRepository(this._datasource);

  @override
  Future<Either<CharacterFailure, List<Character>>> getCharacters(int offset) async {
    try {
      final response = await _datasource.getCharacters(offset);
      return Right(response.map((character) => character.toEntity()).toList());
    } catch (e) {
      return const Left(CharacterFailure());
    }
  }
}
