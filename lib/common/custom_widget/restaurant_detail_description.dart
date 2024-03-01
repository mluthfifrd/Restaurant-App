import 'package:flutter/material.dart';

class RestaurantDetailDescription extends StatelessWidget {
  final String restaurantDescription;

  const RestaurantDetailDescription(
      {super.key, required this.restaurantDescription});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Deskripsi",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          restaurantDescription,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
