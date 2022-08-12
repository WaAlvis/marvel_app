import 'dart:convert';

import 'package:marvel_app_test/providers/providers.dart';


class Character {
  Character({
    required this.id,
    required this.name,
    required this.description,
    // this.modified,
    required this.thumbnail,
    // this.resourceUri,
    // this.comics,
    // this.series,
    // this.stories,
    // this.events,
    required this.urls,
  });

  int id;
  String name;
  String description;

  // String modified;
  Thumbnail thumbnail;

  // String resourceUri;
  // Comics comics;
  // Comics series;
  // Stories stories;
  // Comics events;
  List<UrlCharacter> urls;

  get fullImgCharacter {
    final String imgPath = '${thumbnail.path}.${thumbnail.extension}';
    final String hashApi= MarvelProvider.md5Hash(MarvelProvider.ts).toString();
    return '$imgPath?$hashApi';
  }

  factory Character.fromJson(String str) => Character.fromMap(json.decode(str));

  factory Character.fromMap(Map<String, dynamic> json) => Character(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    // modified: json["modified"],
    thumbnail: Thumbnail.fromMap(json["thumbnail"]),
    // resourceUri: json["resourceURI"],
    // comics: Comics.fromMap(json["comics"]),
    // series: Comics.fromMap(json["series"]),
    // stories: Stories.fromMap(json["stories"]),
    // events: Comics.fromMap(json["events"]),
    urls: List<UrlCharacter>.from(json["urls"].map((x) => UrlCharacter.fromMap(x))),
  );
}

class UrlCharacter {
  UrlCharacter({
    required this.type,
    required this.url,
  });

  String type;
  String url;

  get urlCharacter {
    final String hashApi= MarvelProvider.md5Hash(MarvelProvider.ts).toString();
    return '$url?$hashApi';
  }


  factory UrlCharacter.fromJson(String str) => UrlCharacter.fromMap(json.decode(str));

  factory UrlCharacter.fromMap(Map<String, dynamic> json) => UrlCharacter(
    type: json["type"],
    url: json["url"],
  );
}

class Thumbnail {
  Thumbnail({
    required this.path,
    required this.extension,
  });

  String path;
  String extension;

  factory Thumbnail.fromMap(Map<String, dynamic> json) => Thumbnail(
    path: json["path"],
    extension: json["extension"],
  );
}