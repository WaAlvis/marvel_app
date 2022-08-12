// To parse this JSON data, do
//
//     final charactersResponse = charactersResponseFromMap(jsonString);

import 'dart:convert';

import 'package:marvel_app_test/models/models.dart';

class CharactersResponse {
  CharactersResponse({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHtml,
    required this.etag,
    required this.data,
  });

  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHtml;
  String etag;
  Data data;

  factory CharactersResponse.fromJson(String str) => CharactersResponse.fromMap(json.decode(str));

  factory CharactersResponse.fromMap(Map<String, dynamic> json) =>
      CharactersResponse(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: Data.fromMap(json["data"]),
      );
}

class Data {
  Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  int offset;
  int limit;
  int total;
  int count;
  List<Character> results;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    offset: json["offset"],
    limit: json["limit"],
    total: json["total"],
    count: json["count"],
    results:
    List<Character>.from(json["results"].map((x) => Character.fromMap(x))),
  );
}

// class Url {
//   Url({
//     this.type,
//     this.url,
//   });
//
//   UrlType type;
//   String url;
//
//   factory Url.fromMap(Map<String, dynamic> json) => Url(
//     type: urlTypeValues.map[json["type"]],
//     url: json["url"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "type": urlTypeValues.reverse[type],
//     "url": url,
//   };
// }

// enum UrlType { DETAIL, WIKI, COMICLINK }

// final urlTypeValues = EnumValues({
//   "comiclink": UrlType.COMICLINK,
//   "detail": UrlType.DETAIL,
//   "wiki": UrlType.WIKI
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
