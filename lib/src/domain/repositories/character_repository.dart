import 'package:dartz/dartz.dart';

import '../domain.dart';

abstract class ICharacterRepository {
  Future<Either<CharacterFailure, List<Character>>> getCharacters(int offset);
}
