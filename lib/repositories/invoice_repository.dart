import 'package:hive_flutter/hive_flutter.dart';

import '../database/hive_database.dart';
import '../models/invoice.dart';

class InvoiceRepository {
  final Box<Invoice> _box = Hive.box<Invoice>(HiveDatabase.invoiceBox);

  List<Invoice> getInvoices() {
    return _box.values.toList().reversed.toList();
  }

  Future<void> addInvoice(Invoice invoice) async {
    await _box.add(invoice);
  }

  Future<void> deleteInvoice(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> clearInvoices() async {
    await _box.clear();
  }
}
