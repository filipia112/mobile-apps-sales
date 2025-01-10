import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/cart_model.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  DBHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE cart (
      idCart TEXT PRIMARY KEY,
      idMenuProduk TEXT, 
      hargaPerUnit INTEGER,
      jumlahUnit INTEGER,
      totalHarga INTEGER,
      gambarPath TEXT,
      nmProduk TEXT,
      deskripsi TEXT,
      nmUnit TEXT,
      kodePabrik TEXT,
      isOrderDetail INTEGER DEFAULT 0
    )
  ''');
  }
  Future<int> insertCart(Cart cart) async {
    Database db = await instance.database;
    return await db.insert('cart', cart.toMap());
  }

  Future<List<Cart>> getAllCarts() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cart',
      where: 'isOrderDetail = ?',
      whereArgs: [0],
    );
    return maps.map((map) {
      return Cart.fromMap(map);
    }).toList();
  }



  Future<int> updateIsOrderDetail(String idCart, bool isOrderDetail) async {
    Database db = await instance.database;
    return await db.update(
      'cart',
      {'isOrderDetail': isOrderDetail ? 1 : 0},
      where: 'idCart = ?',
      whereArgs: [idCart],
    );
  }


  Future<int> removeCart(String idCart) async {
    Database db = await instance.database;
    return await db.delete(
      'cart',
      where: 'idCart = ?',
      whereArgs: [idCart],
    );
  }
  Future<void> clearCart() async {
    Database db = await instance.database;
    await db.delete(
      'cart',
      where: 'isOrderDetail = ?',
      whereArgs: [0],
    );
  }
}