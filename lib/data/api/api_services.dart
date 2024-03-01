import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantList> getAllRestaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      final dynamic jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        final result = RestaurantList.fromJson(jsonResponse);
        return result;
      } else {
        throw Exception('Format JSON tidak sesuai');
      }
    } else {
      throw Exception('Gagal mendapatkan data seluruh Restaurant');
    }
  }

  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      final dynamic jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        final result = RestaurantDetail.fromJson(jsonResponse);
        return result;
      } else {
        throw Exception('Format JSON tidak sesuai');
      }
    } else {
      throw Exception('Gagal mendapatkan detail Restaurant');
    }
  }

  Future<RestaurantSearch> findRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      final dynamic jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        final result = RestaurantSearch.fromJson(jsonResponse);
        return result;
      } else {
        throw Exception('Format JSON tidak sesuai');
      }
    } else {
      throw Exception('Restaurant Tidak di Temukan');
    }
  }

  Future<CustomerReview> addCustomerReview(
      String restaurantId, String name, String review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'id': restaurantId, 'name': name, 'review': review}),
    );

    if (response.statusCode == 201) {
      return CustomerReview.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add Customer Review');
    }
  }
}
