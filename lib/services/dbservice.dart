import 'package:foodsNepal/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static String dbName = "foods.db";
  DatabaseService._internal();
  static final DatabaseService instance = DatabaseService._internal();
  static Database _db;
  Future<Database> get database async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    var path = await getApplicationDocumentsDirectory();
    var apath = path.path + "/" + dbName;
    var db = await openDatabase(apath, version: 1, onCreate: _createDb);
    return db;
  }

  _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE carts(id INTEGER PRIMARY KEY,name TEXT,category TEXT,_id TEXT,quantity INT,imageUrl TEXT,price INT,rating INT,descriptions TEXT)");
  }

  Future<int> insertIntoCart(Product p) async {
    var db = await database;
    return await db.insert("carts", p.toJson());
  }

  Future<List<Product>> getCartItems() async {
    var db = await database;
    var data = await db.query("carts", orderBy: "id desc");
    List<Product> p = new List<Product>();
    for (var d in data) {
      p.add(Product.fromJson(d));
    }
    return p;
  }

  Future<int> deleteItemsFromCart(Product ep) async {
    var db = await database;
    var data = await db.delete("carts", where: "_id=?", whereArgs: [ep.id]);
    return data;
  }
}
