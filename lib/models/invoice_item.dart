import 'package:hive/hive.dart';

part 'invoice_item.g.dart';

@HiveType(typeId: 4)
class InvoiceItem extends HiveObject {
  @HiveField(0)
  String productId;

  @HiveField(1)
  String productName;

  @HiveField(2)
  double costPrice;

  @HiveField(3)
  double sellingPrice;

  @HiveField(4)
  int quantity;

  InvoiceItem({
    required this.productId,
    required this.productName,
    required this.costPrice,
    required this.sellingPrice,
    required this.quantity,
  });

  double get totalSale => sellingPrice * quantity;

  double get totalCost => costPrice * quantity;

  double get totalProfit => totalSale - totalCost;
}
