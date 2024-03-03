import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _btnBookmark = 'bookmarks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/fav_restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_btnBookmark (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating DECIMAL
          )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertBookmark(RestaurantList restaurant) async {
    final db = await database;
    await db!.insert(_btnBookmark, restaurant.toJson());
  }

  Future<List<RestaurantList>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_btnBookmark);

    return results.map((res) => RestaurantList.fromJson(res)).toList();
  }

  Future<Map> getBookmarkById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _btnBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeBookmark(String id) async {
    final db = await database;

    await db!.delete(
      _btnBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
