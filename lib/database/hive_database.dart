import 'package:hive_flutter/hive_flutter.dart';

import '../models/cart_item.dart';
import '../models/expense.dart';
import '../models/invoice.dart';
import '../models/invoice_item.dart';
import '../models/product.dart';
import '../models/sale.dart';

class HiveDatabase {
  static const productBox = "products";
  static const salesBox = "sales";
  static const expenseBox = "expenses";
  static const invoiceBox = "invoices";

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductAdapter());
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(SaleAdapter());
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ExpenseAdapter());
    }

    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(CartItemAdapter());
    }

    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(InvoiceItemAdapter());
    }

    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(InvoiceAdapter());
    }

    if (!Hive.isBoxOpen(productBox)) {
      await Hive.openBox<Product>(productBox);
    }

    if (!Hive.isBoxOpen(salesBox)) {
      await Hive.openBox<Sale>(salesBox);
    }

    if (!Hive.isBoxOpen(expenseBox)) {
      await Hive.openBox<Expense>(expenseBox);
    }

    if (!Hive.isBoxOpen(invoiceBox)) {
      await Hive.openBox<Invoice>(invoiceBox);
    }
  }
}
