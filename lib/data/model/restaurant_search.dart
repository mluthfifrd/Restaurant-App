import 'dart:convert';

class RestaurantSearchData {
  bool error;
  int founded;
  List<RestaurantSearch> restaurants;

  RestaurantSearchData({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchData.fromRawJson(String str) =>
      RestaurantSearchData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearchData.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchData(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantSearch>.from(
            json["restaurants"].map((x) => RestaurantSearch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantSearch {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  RestaurantSearch({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantSearch.fromRawJson(String str) =>
      RestaurantSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
