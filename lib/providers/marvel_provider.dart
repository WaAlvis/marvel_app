import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_app_test/models/comics_response.dart';
import 'package:marvel_app_test/models/models.dart';

class MarvelProvider extends ChangeNotifier {
  //  hash = md5(ts+privateKey+publicKey)

  final String _baseUrl = 'gateway.marvel.com:443';
  static const String _apiKey = 'c6e452efd0c7c69be7a7835f2985b12a';
  static const String _offset = '0'; //cantidad de elementos que se quedan fuera de la consulta
  static const String _limit = '20'; //Cantidad de elementos que trae la cosulta
  static const String ts = '1';
  List<Character> charactersMarvel = [];
  List<Comic> comicsMarvel = [];

  MarvelProvider() {
    print('MarverProvider Inicializado...');

    this.getCharacters();
    this.getComics();
  }

   Future<String> _getJsonData (String endPoint, [String offset = _offset, String limit = _limit]) async {
    Uri url = Uri.https(_baseUrl, endPoint, {
      'ts': ts,
      'apikey': _apiKey,
      'hash': md5Hash(ts).toString(),
      'limit' : limit,
      'offset' : offset,
    });
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    return response.body;
  }

  getComics() async {
    final jsonData = await _getJsonData('v1/public/comics');
    final comicResponse = ComicsResponse.fromJson(jsonData);

    comicsMarvel = comicResponse.data.results;
    notifyListeners();
  }

  Future<void> getCharacters() async {
    const String offsetCharacters = '0';
    const String limitCharacters= '5';
    final jsonData = await _getJsonData('v1/public/characters',offsetCharacters,limitCharacters);
    final charactersResponse = CharactersResponse.fromJson(jsonData);

    charactersMarvel = charactersResponse.data.results;
    notifyListeners();
  }

  static Digest md5Hash(String ts) {
    const String privateKey = 'ca53232a1e34b3fa8b3816921d0d94f6122e3af7';
    final String digestMd5 = ts + privateKey + _apiKey;
    final List<int> bytes = utf8.encode(digestMd5); // data being hashed
    return md5.convert(bytes);
  }
}
