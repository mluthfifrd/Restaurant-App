import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getBookmarks();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantList> _bookmarks = [];
  List<RestaurantList> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    _state = ResultState.loading;
    notifyListeners();
    _bookmarks = await databaseHelper.getBookmarks();
    if (_bookmarks.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Belum Ada Restoran Favorit';
    }
    notifyListeners();
  }

  void addBookmark(RestaurantList restaurant) async {
    try {
      await databaseHelper.insertBookmark(restaurant);
      _getBookmarks();
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String id) async {
    final bookmarkedArticle = await databaseHelper.getBookmarkById(id);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeBookmark(String id) async {
    try {
      await databaseHelper.removeBookmark(id);
      // _getBookmarks();
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
