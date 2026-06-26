import 'package:hive_flutter/hive_flutter.dart';

import '../database/hive_database.dart';
import '../models/product.dart';

class ProductRepository {
  final Box<Product> _box = Hive.box<Product>(HiveDatabase.productBox);

  List<Product> getProducts() {
    return _box.values.toList();
  }

  Future<void> addProduct(Product product) async {
    await _box.add(product);
  }

  Future<void> deleteProduct(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> updateProduct(int index, Product product) async {
    await _box.putAt(index, product);
  }
}
