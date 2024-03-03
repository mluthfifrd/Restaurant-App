// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_widget/card_restaurant_list.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';

import '../utils/result_state.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final _textController = TextEditingController();

  clearSearchQuery() {
    setState(() {
      _textController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RestaurantSearchPage.routeName);
            },
            style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 50)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.search),
                SizedBox(width: 8),
                Text('Cari Restoran'),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "Nikmati Petualangan Rasa, Di Jelajah Kuliner!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15),
          Expanded(child: _listRestaurant()),
        ],
      ),
    );
  }

  Widget _listRestaurant() {
    return ChangeNotifierProvider(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
      child: Consumer<RestaurantListProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.resultRestaurantList.restaurants.length,
              itemBuilder: (context, index) {
                var restaurantList =
                    state.resultRestaurantList.restaurants[index];
                return CardRestaurantList(restaurantList: restaurantList);
              },
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
}
