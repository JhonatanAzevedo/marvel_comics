import 'package:dartz/dartz.dart';

import '../domain.dart';

abstract class IGetCharacterUsecase {
  Future<Either<CharacterFailure, List<Character>>> call(int offset);
}

class GetCharacterUsecase implements IGetCharacterUsecase {
  final ICharacterRepository _repository;

  GetCharacterUsecase(this._repository);

  @override
  Future<Either<CharacterFailure, List<Character>>> call(int offset) {
    return _repository.getCharacters(offset);
  }
}
