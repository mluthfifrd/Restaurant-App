// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:restaurant_app/data/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  late final ApiService apiService;
  late final String query;

  RestaurantSearchProvider({required this.apiService, required this.query}) {
    findRestaurant(query);
  }

  late RestaurantSearchData _restaurantSearch;
  late ResultState _state;
  String _message = "";

  String get message => _message;

  RestaurantSearchData get resultRestaurantSearch => _restaurantSearch;

  ResultState get state => _state;

  Future<dynamic> findRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.findRestaurant(query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restoran Tidak Ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearch = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Errors --> Tidak ada koneksi Internet';
    }
  }
}
