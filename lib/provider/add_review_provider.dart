// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:restaurant_app/data/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class AddReviewProvider extends ChangeNotifier {
  late final ApiService apiService;
  late final String restaurantId;
  late final String name;
  late final String review;

  AddReviewProvider(
      {required this.apiService,
      required this.restaurantId,
      required this.name,
      required this.review}) {
    addReview(restaurantId, name, review);
  }

  late CustomerReview _addCustomerReview;
  late ResultState _state;
  String _message = "";

  String get message => _message;

  CustomerReview get resultAddCustomerReview => _addCustomerReview;

  ResultState get state => _state;

  Future<dynamic> addReview(String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      await apiService.addCustomerReview(restaurantId, name, review);
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Errors --> $e';
    }
  }
}
