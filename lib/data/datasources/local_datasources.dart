import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';
import '../models/order_report.dart';

class LocalDatasource {
  final String dbName = 'products_local01.db';
  final String tableName = 'products'; //  Tambahkan kembali variabel ini
  final String orderTable =
      'order_reports'; //  Tambahkan variabel untuk laporan

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return await openDatabase(
      path,
      version: 2, // Update jika ada perubahan tabel
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,  
            name TEXT, 
            image TEXT, 
            description TEXT, 
            price REAL, 
            quantity INTEGER)''',
        );

        await db.execute(
          '''CREATE TABLE IF NOT EXISTS $orderTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            orderId INTEGER,
            date TEXT,
            totalAmount REAL,
            paymentMethod TEXT,
            cash REAL,
            change REAL)''',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('DROP TABLE IF EXISTS order_reports'); // Reset tabel
          await db.execute('''CREATE TABLE order_reports(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          orderId TEXT, 
          date TEXT, 
          totalAmount REAL, 
          paymentMethod TEXT, 
          cash REAL, 
          change REAL)''');
        }
      },
    );
  }

  //================= PRODUCT FUNCTIONS =================//
  Future<int> insertProduct(Product product) async {
    final db = await _openDatabase();
    final data = product.toMap();
    data.remove('id');
    return await db.insert(tableName, data); //  Gunakan `tableName`
  }

  Future<List<Product>> getProducts() async {
    final db = await _openDatabase();
    final maps =
        await db.query(tableName, orderBy: 'id ASC'); //  Gunakan `tableName`
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<Product?> getProductById(int id) async {
    final db = await _openDatabase();
    final maps = await db.query(tableName,
        where: 'id = ?', whereArgs: [id]); //  Gunakan `tableName`
    return maps.isNotEmpty ? Product.fromMap(maps.first) : null;
  }

  Future<int> updateProduct(Product product) async {
    final db = await _openDatabase();
    final data = product.toMap();
    data.remove('id');
    return await db.update(tableName, data,
        where: 'id = ?', whereArgs: [product.id]); //  Gunakan `tableName`
  }

  Future<int> deleteProductById(int id) async {
    final db = await _openDatabase();
    return await db.delete(tableName,
        where: 'id = ?', whereArgs: [id]); //  Gunakan `tableName`
  }

  //================= ORDER REPORT FUNCTIONS =================//
  Future<int> insertOrderReport(OrderReport report) async {
    final db = await _openDatabase();
    final data = report.toMap();
    data.remove('id'); //  Pastikan tidak menyertakan 'id', SQLite yang mengisi
    return await db.insert('order_reports', data);
  }

  Future<List<OrderReport>> getAllOrderReports() async {
    final db = await _openDatabase();
    final maps = await db.query('order_reports', orderBy: 'id DESC');

    print("Data dari database: $maps"); // Debugging

    return List.generate(maps.length, (i) => OrderReport.fromMap(maps[i]));
  }

  Future<int> deleteOrderReportById(int id) async {
    final db = await _openDatabase();
    return await db.delete(orderTable,
        where: 'id = ?', whereArgs: [id]); // ✅ Gunakan `orderTable`
  }
}
