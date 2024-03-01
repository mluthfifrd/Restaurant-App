import 'package:flutter/material.dart';

class RestaurantDetailTitle extends StatelessWidget {
  final String restaurantName;
  final String restaurantCity;

  const RestaurantDetailTitle(
      {super.key, required this.restaurantName, required this.restaurantCity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          restaurantName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 20,
            ),
            Text(
              'Kota $restaurantCity',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
