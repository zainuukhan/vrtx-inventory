import 'package:hive_flutter/hive_flutter.dart';

import '../database/hive_database.dart';
import '../models/sale.dart';

class SaleRepository {
  final Box<Sale> _box = Hive.box<Sale>(HiveDatabase.salesBox);

  List<Sale> getSales() {
    return _box.values.toList().reversed.toList();
  }

  Future<void> addSale(Sale sale) async {
    await _box.add(sale);
  }

  Future<void> deleteSale(int index) async {
    await _box.deleteAt(index);
  }

  double grossSales() {
    double total = 0;

    for (final sale in _box.values) {
      total += sale.totalSale;
    }

    return total;
  }

  double grossProfit() {
    double total = 0;

    for (final sale in _box.values) {
      total += sale.totalProfit;
    }

    return total;
  }
}
