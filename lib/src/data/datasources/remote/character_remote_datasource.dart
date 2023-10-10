import 'dart:async';
import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';

import '../../models/response/caraceter_model.dart';

var ts = DateTime.now().microsecondsSinceEpoch.toString();
var publicKey = '3704d2845a491d87255270a6c3e2c30c';
var privateKey = 'f92377ae9b7afbd77dad5780fc1fd394952b7845';

abstract class ICharacterDatasource {
  FutureOr<List<CharacterModel>> getCharacters(int offset);
}

class CharacterDatasource implements ICharacterDatasource {
  final Dio dio;
  

  CharacterDatasource(this.dio);

  @override
  FutureOr<List<CharacterModel>> getCharacters(int offset) async {
    
    final hash = _generateMd5();
    final result = await dio.get("public/characters?offset=$offset&ts=$ts&apikey=$publicKey&hash=$hash");
    return (result.data["data"]["results"] as List).map((character) => CharacterModel.fromJson(character)).toList();
  }
}

String _generateMd5() {
  var content = const Utf8Encoder().convert('$ts$privateKey$publicKey');
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}
