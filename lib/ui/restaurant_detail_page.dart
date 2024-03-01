import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_add_review.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_description.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_category.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_review.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_title.dart';
import 'package:restaurant_app/common/custom_widget/restaurant_detail_menu.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String linkImage = "https://restaurant-api.dicoding.dev/images/medium/";
  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  Widget _restaurantDetail() {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
          apiService: ApiService(), restaurantId: restaurantId),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            var restaurant = state.resultRestaurantDetail.restaurant;
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: "$linkImage${restaurant.pictureId}",
                        // ignore: prefer_const_constructors
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          child: Image.network(
                            "$linkImage${restaurant.pictureId}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RestaurantDetailTitle(
                          restaurantName: restaurant.name,
                          restaurantCity: restaurant.city),
                      RestaurantDetailCategory(
                          categories: restaurant.categories),
                      RestaurantDetailDescription(
                          restaurantDescription: restaurant.description),
                      RestaurantDetailMenu(menus: restaurant.menus),
                      RestaurantDetailReview(
                          reviews: restaurant.customerReviews),
                      RestaurantDetailAddReview(restaurantId: restaurant.id)
                    ],
                  ),
                ),
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
        ),
        body: _restaurantDetail());
  }
}
