// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:restaurant_app/data/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

enum ResultSearchState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  late final ApiService apiService;
  late final String query;

  RestaurantSearchProvider({required this.apiService, required this.query}) {
    findRestaurant(query);
  }

  late RestaurantSearch _restaurantSearch;
  late ResultSearchState _state;
  String _message = "";

  String get message => _message;

  RestaurantSearch get resultRestaurantSearch => _restaurantSearch;

  ResultSearchState get state => _state;

  Future<dynamic> findRestaurant(String query) async {
    try {
      _state = ResultSearchState.loading;
      notifyListeners();
      final response = await apiService.findRestaurant(query);
      if (response.restaurants.isEmpty) {
        _state = ResultSearchState.noData;
        notifyListeners();
        return _message = 'Restoran Tidak Ditemukan';
      } else {
        _state = ResultSearchState.hasData;
        notifyListeners();
        return _restaurantSearch = response;
      }
    } catch (e) {
      _state = ResultSearchState.error;
      notifyListeners();
      return _message = 'Errors --> Tidak ada koneksi Internet';
    }
  }
}
