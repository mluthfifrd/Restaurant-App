import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import 'get_all_restaurant_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const url = ApiService.baseUrl;

  group('Get All Restaurant From API', () {
    test('returns a Post if the http call completes successfully', () async {
      var client = MockClient();

      when(client.get(Uri.parse("$url/list"))).thenAnswer((_) async {
        return http.Response('''{
          "error": false,
          "message": "success",
          "count": 20,
          "restaurants": []}''', 200);
      });

      expect(await ApiService().getAllRestaurant(), isA<RestaurantListData>());
    });
  });
}
