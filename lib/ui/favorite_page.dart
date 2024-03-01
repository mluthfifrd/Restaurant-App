import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  static const String favoriteTitle = 'Favorit';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Favorite',
            style: Theme.of(context).textTheme.headlineSmall),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
