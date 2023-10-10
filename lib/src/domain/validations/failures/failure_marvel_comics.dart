class CharacterFailure {
  final String? message;

  
  const CharacterFailure([this.message]);

  factory CharacterFailure.serverError([String? message]) => CharacterFailure(message);

  factory CharacterFailure.timeout() => const CharacterFailure();
}
