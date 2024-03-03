import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_widget/card_restaurant_list.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';

import '../utils/result_state.dart';

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
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ChangeNotifierProvider(
        create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        child: Consumer<DatabaseProvider>(
          builder: (context, provider, child) {
            if (provider.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.state == ResultState.hasData) {
              return ListView.builder(
                itemCount: provider.bookmarks.length,
                itemBuilder: (context, index) {
                  return CardRestaurantList(
                      restaurantList: provider.bookmarks[index]);
                },
              );
            } else {
              return Center(
                child: Material(
                  child: Text(provider.message),
                ),
              );
            }
          },
        ));
  }
}
