import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sale.dart';
import '../repositories/sale_repository.dart';

final saleRepositoryProvider = Provider((ref) => SaleRepository());

final saleProvider = StateNotifierProvider<SaleNotifier, List<Sale>>(
  (ref) => SaleNotifier(ref.read(saleRepositoryProvider)),
);

class SaleNotifier extends StateNotifier<List<Sale>> {
  final SaleRepository repository;

  SaleNotifier(this.repository) : super([]) {
    loadSales();
  }

  void loadSales() {
    state = repository.getSales();
  }

  Future<void> addSale(Sale sale) async {
    await repository.addSale(sale);
    loadSales();
  }

  double grossSales() {
    return repository.grossSales();
  }

  double grossProfit() {
    return repository.grossProfit();
  }
}
