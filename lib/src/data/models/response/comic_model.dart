import '../../../domain/entities/comic.dart';

class ComicModel {
  final String name;

  ComicModel({required this.name});

  factory ComicModel.fromJson(Map<String, dynamic> map) {
    return ComicModel(
      name: map['name'] as String,
    );
  }

  Comic toEntity() {
    return Comic(name: name);
  }
}
