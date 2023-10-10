import 'package:equatable/equatable.dart';

import 'comic.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final List<Comic> comics;

  const Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.comics,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      thumbnail,
      comics,
    ];
  }
}
