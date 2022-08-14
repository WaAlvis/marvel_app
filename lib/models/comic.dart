import 'dart:convert';

import 'package:marvel_app_test/providers/providers.dart';

class Comic {
  Comic({
    required this.id,
    required this.title,
    this.description,
    // required this.format,
    required this.pageCount,
    // this.textObjects,
    required this.resourceUri,
    required this.urls,
    // this.series,
    // this.variants,
    // this.collections,
    // this.collectedIssues,
    // this.dates,
    required this.prices,
    required this.thumbnail,
    // this.images,
    // this.creators,
    // this.characters,
    // this.stories,
    // this.events,
  });

  int id;
  String title;
  String? description;

  // Format format;
  int pageCount;

  // List<TextObject> textObjects;
  String resourceUri;
  List<UrlComic> urls;

  // Series series;
  // List<Series> variants;
  // List<dynamic> collections;
  // List<Series> collectedIssues;
  // List<Date> dates;
  List<Price> prices;
  Cover thumbnail;

  // List<Thumbnail> images;
  // Creators creators;
  // Characters characters;
  // Stories stories;
  // Characters events;

  get priceComic{
    if (prices.isEmpty)
      return 'No found';
    return prices[0].price.toString();
  }

  get fullCoverImg {
    final String imgPath = '${thumbnail.path}.${thumbnail.extension}';
    final String hashApi= MarvelProvider.md5Hash(MarvelProvider.ts).toString();
    return '$imgPath?$hashApi';
  }


  factory Comic.fromJson(String str) => Comic.fromMap(json.decode(str));

  factory Comic.fromMap(Map<String, dynamic> json) => Comic(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        // format: formatValues.map[json["format"]],
        pageCount: json["pageCount"],
        resourceUri: json["resourceURI"],
        urls: List<UrlComic>.from(json["urls"].map((x) => UrlComic.fromMap(x))),
        // series: Series.fromMap(json["series"]),
        // variants: List<Series>.from(json["variants"].map((x) => Series.fromMap(x))),
        // collections: List<dynamic>.from(json["collections"].map((x) => x)),
        // collectedIssues: List<Series>.from(json["collectedIssues"].map((x) => Series.fromMap(x))),
        // dates: List<Date>.from(json["dates"].map((x) => Date.fromMap(x))),
        prices: List<Price>.from(json["prices"].map((x) => Price.fromMap(x))),
        thumbnail: Cover.fromMap(json["thumbnail"]),
        // images: List<Thumbnail>.from(json["images"].map((x) => Thumbnail.fromMap(x))),
        // creators: Creators.fromMap(json["creators"]),
        // characters: Characters.fromMap(json["characters"]),
        // stories: Stories.fromMap(json["stories"]),
        // events: Characters.fromMap(json["events"]),
      );
}

class Cover {
  Cover({
    required this.path,
    required this.extension,
  });

  String path;
  String extension;

  factory Cover.fromJson(String str) => Cover.fromMap(json.decode(str));

  factory Cover.fromMap(Map<String, dynamic> json) => Cover(
        path: json["path"],
        extension: json["extension"],
      );
}

class Price {
  Price({
    required this.type,
    required this.price,
  });

  String type;
  double price;

  factory Price.fromJson(String str) => Price.fromMap(json.decode(str));

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        type: json["type"],
        price: json["price"].toDouble(),
      );
}

class UrlComic {
  UrlComic({
    required this.type,
    required this.url,
  });

  String type;
  String url;

  factory UrlComic.fromJson(String str) => UrlComic.fromMap(json.decode(str));

  factory UrlComic.fromMap(Map<String, dynamic> json) => UrlComic(
        type: json["type"],
        url: json["url"],
      );
}
