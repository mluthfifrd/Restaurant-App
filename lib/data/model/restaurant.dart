class RestaurantListData {
  bool error;
  String message;
  int count;
  List<RestaurantList> restaurants;

  RestaurantListData({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListData.fromJson(Map<String, dynamic> json) {
    return RestaurantListData(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      restaurants: List<RestaurantList>.from(
        (json["restaurants"]).map((x) => RestaurantList.fromJson(x)).where(
            (restaurant) =>
                restaurant.id != null &&
                restaurant.name != null &&
                restaurant.description != null &&
                restaurant.pictureId != null &&
                restaurant.city != null &&
                restaurant.rating != null),
      ),
    );
  }
}

class RestaurantList {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  RestaurantList({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
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
