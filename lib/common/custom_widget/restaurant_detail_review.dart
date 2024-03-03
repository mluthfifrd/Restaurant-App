import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class RestaurantDetailReview extends StatelessWidget {
  final List<CustomerReview> reviews;

  const RestaurantDetailReview({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 25),
        Text(
          "Ulasan Pelanggan (${reviews.length})",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Column(
          // Tambahkan Column di sini
          children: reviews.map(
            (review) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      "${review.name}, ${review.date}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.review,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    dense: true,
                  ),
                ),
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 25)
      ],
    );
  }
}
