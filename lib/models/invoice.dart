import 'package:hive/hive.dart';

import 'invoice_item.dart';

part 'invoice.g.dart';

@HiveType(typeId: 5)
class Invoice extends HiveObject {
  @HiveField(0)
  String invoiceId;

  @HiveField(1)
  String customerName;

  @HiveField(2)
  String phone;

  @HiveField(3)
  DateTime dateTime;

  @HiveField(4)
  List<InvoiceItem> items;

  @HiveField(5)
  double totalSale;

  @HiveField(6)
  double totalCost;

  @HiveField(7)
  double totalProfit;

  Invoice({
    required this.invoiceId,
    required this.customerName,
    required this.phone,
    required this.dateTime,
    required this.items,
    required this.totalSale,
    required this.totalCost,
    required this.totalProfit,
  });
}
