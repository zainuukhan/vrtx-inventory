import 'package:hive_flutter/hive_flutter.dart';

import '../models/product.dart';

class HiveDatabase {
  static const String productBox = "products";

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProductAdapter());

    await Hive.openBox<Product>(productBox);
  }
}
