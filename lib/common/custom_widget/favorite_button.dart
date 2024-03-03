import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class FavoriteButton extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const FavoriteButton({super.key, required this.restaurantDetail});

  RestaurantList get restaurantList => RestaurantList(
      id: restaurantDetail.id,
      name: restaurantDetail.name,
      description: restaurantDetail.description,
      pictureId: restaurantDetail.pictureId,
      city: restaurantDetail.city,
      rating: restaurantDetail.rating);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurantDetail.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Positioned(
              right: 50.0,
              top: 245.0,
              child: isBookmarked
                  ? ElevatedButton(
                      onPressed: () =>
                          provider.removeBookmark(restaurantDetail.id),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        shape: const CircleBorder(),
                        minimumSize: const Size(50, 50),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red.shade600,
                        size: 30.0,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () => provider.addBookmark(restaurantList),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        shape: const CircleBorder(),
                        minimumSize: const Size(50, 50),
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.red.shade600,
                        size: 30.0,
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
