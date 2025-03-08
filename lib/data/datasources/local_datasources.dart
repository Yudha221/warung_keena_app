import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';

class LocalDatasource {
  final String dbName = 'products_local01.db';
  final String tableName = 'products';

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,  
            name TEXT, 
            image TEXT, 
            description TEXT, 
            price REAL, 
            quantity INTEGER)''',
        );
      },
    );
  }

  Future<int> insertProduct(Product product) async {
    final db = await _openDatabase();
    final data = product.toMap();
    data.remove('id'); // Hapus id agar SQLite menambahkan otomatis
    return await db.insert(tableName, data);
  }

  //get all product
  Future<List<Product>> getProducts() async {
    final db = await _openDatabase();
    final maps = await db.query(tableName, orderBy: 'id ASC');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  //get product by id
  Future<Product?> getProductById(int id) async {
    final db = await _openDatabase();
    final maps = await db.query(tableName, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    } else {
      return null; // Return null jika tidak ditemukan
    }
  }

  //update product
  Future<int> updateProduct(Product product) async {
    final db = await _openDatabase();
    final data = product.toMap();
    data.remove('id'); // Hapus id agar tidak ikut diperbarui
    return await db.update(
      tableName,
      data,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  //delete product
  Future<int> deleteProductById(int id) async {
    final db = await _openDatabase();
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
