// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:restaurant_app/data/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import '../utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  late final ApiService apiService;
  late final String restaurantId;

  RestaurantDetailProvider(
      {required this.apiService, required this.restaurantId}) {
    _getDetailRestaurant(restaurantId);
  }

  late RestaurantDetailData _restaurantDetail;
  late ResultState _state;
  String _message = "";

  String get message => _message;

  RestaurantDetailData get resultRestaurantDetail => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> _getDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getDetailRestaurant(id);
      if (response.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data Detail Restaurant Tidak Ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Errors --> Tidak ada koneksi Internet';
    }
  }
}
