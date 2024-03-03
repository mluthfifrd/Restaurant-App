import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:restaurant_app/common/custom_widget/favorite_button.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_add_review.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_description.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_category.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_review.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_title.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_menu.dart';
import 'package:restaurant_app/common/custom_widget/favorite_button.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

import '../utils/result_state.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String restaurantId;
  final String linkImage = ApiService.linkImage;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  Widget _restaurantDetail() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(
              apiService: ApiService(), restaurantId: restaurantId),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            var restaurantDetail = state.resultRestaurantDetail.restaurant;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Image.network(
                            "$linkImage${restaurantDetail.pictureId}",
                            fit: BoxFit.cover,
                            height: 270.0,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RestaurantDetailTitle(
                                    restaurantName: restaurantDetail.name,
                                    restaurantCity: restaurantDetail.city),
                                RestaurantDetailCategory(
                                    categories: restaurantDetail.categories),
                                RestaurantDetailDescription(
                                    restaurantDescription:
                                        restaurantDetail.description),
                                RestaurantDetailMenu(
                                    menus: restaurantDetail.menus),
                                RestaurantDetailReview(
                                    reviews: restaurantDetail.customerReviews),
                                RestaurantDetailAddReview(
                                  restaurantId: restaurantDetail.id,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      FavoriteButton(restaurantDetail: restaurantDetail)
                    ],
                  ),
                ],
              ),
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Restoran',
            style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black87,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: _restaurantDetail(),
    );
  }
}
