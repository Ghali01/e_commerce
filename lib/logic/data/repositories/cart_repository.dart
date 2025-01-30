import 'package:sqflite/sqflite.dart';

class CartRepository {
  Future<Database> get _db {
    return openDatabase('carts', version: 1, onCreate: _onCreateDb);
  }

  void _onCreateDb(Database db, int version) {
    db.execute('''
  CREATE TABLE cart_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    image TEXT NOT NULL,
    price TEXT NOT NULL,
    quantity INTEGER NOT NULL
  )
''');
  }

  //insert cart item
  Future<void> insertCartItem(Map<String, dynamic> cartItem) async {
    final db = await _db;
    await db.insert('cart_items', cartItem);
    db.close();
  }

  //delete cart item
  Future<void> deleteCartItem(int id) async {
    final db = await _db;
    await db.delete('cart_items', where: 'id = ?', whereArgs: [id]);
    db.close();
  }

  //get cart items
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await _db;
    final result = await db.query('cart_items');
    db.close();
    return result;
  }

  //clear cart
  Future<void> clearCart() async {
    final db = await _db;
    await db.delete('cart_items');
    db.close();
  }
}
