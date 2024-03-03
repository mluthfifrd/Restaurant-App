// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:flutter/material.dart';

import '../utils/result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  late final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantListData _restaurantList;
  late ResultState _state;
  String _message = "";

  String get message => _message;

  RestaurantListData get resultRestaurantList => _restaurantList;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getAllRestaurant();
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data Tidak Ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Errors --> Tidak ada koneksi Internet';
    }
  }
}
