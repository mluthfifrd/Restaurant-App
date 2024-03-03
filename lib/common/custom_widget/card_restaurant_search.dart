// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class CardRestaurantSearch extends StatelessWidget {
  final RestaurantSearch restaurantSearch;
  final String linkImage = ApiService.linkImage;

  const CardRestaurantSearch({Key? key, required this.restaurantSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius:
              BorderRadius.circular(10.0), // Atur radius sesuai keinginan Anda
          child: Hero(
            tag: "$linkImage${restaurantSearch.pictureId}",
            child: Image.network(
              "$linkImage${restaurantSearch.pictureId}",
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Hero(
          tag: restaurantSearch.name,
          child: Text(
            restaurantSearch.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                ),
                Text(
                  'Kota ${restaurantSearch.city}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: restaurantSearch.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                  ignoreGestures: true,
                  onRatingUpdate: (_) {},
                ),
                const SizedBox(width: 5),
                Text(
                  restaurantSearch.rating.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            )
          ],
        ),
        onTap: () {
          Navigator.of(context).pushNamed(RestaurantDetailPage.routeName,
              arguments: restaurantSearch.id);
        },
      ),
    );
  }
}
