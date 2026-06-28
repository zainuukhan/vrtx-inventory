import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/invoice.dart';
import '../repositories/invoice_repository.dart';

final invoiceRepositoryProvider = Provider((ref) => InvoiceRepository());

final invoiceProvider = StateNotifierProvider<InvoiceNotifier, List<Invoice>>(
  (ref) => InvoiceNotifier(ref.read(invoiceRepositoryProvider)),
);

class InvoiceNotifier extends StateNotifier<List<Invoice>> {
  final InvoiceRepository repository;

  InvoiceNotifier(this.repository) : super([]) {
    loadInvoices();
  }

  void loadInvoices() {
    state = repository.getInvoices();
  }

  Future<void> addInvoice(Invoice invoice) async {
    await repository.addInvoice(invoice);
    loadInvoices();
  }

  Future<void> deleteInvoice(int index) async {
    await repository.deleteInvoice(index);
    loadInvoices();
  }

  double get totalRevenue => state.fold(0, (sum, e) => sum + e.totalSale);

  double get totalProfit => state.fold(0, (sum, e) => sum + e.totalProfit);

  int get totalInvoices => state.length;
}
