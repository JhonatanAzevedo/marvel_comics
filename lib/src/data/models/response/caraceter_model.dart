import 'package:marvel_comics/src/data/models/response/comic_model.dart';

import '../../../domain/domain.dart';

class CharacterModel {
  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final List<ComicModel> comics;

  CharacterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.comics,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      thumbnail: (map['thumbnail']['path'] + '.' + map['thumbnail']['extension']) as String,
      comics: (map['comics']['items'] as List).map((e) => ComicModel.fromJson(e)).toList()
    );
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      description: description,
      thumbnail: thumbnail,
      comics: comics.map((e) => e.toEntity()).toList(),
    );
  }
}
