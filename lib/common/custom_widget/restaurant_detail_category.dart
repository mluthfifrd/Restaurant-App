import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class RestaurantDetailCategory extends StatelessWidget {
  final List<Category> categories;

  const RestaurantDetailCategory({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: categories.map((category) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "#${category.name}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 5)
      ],
    );
  }
}
