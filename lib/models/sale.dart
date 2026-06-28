import 'package:hive/hive.dart';

part 'sale.g.dart';

@HiveType(typeId: 1)
class Sale extends HiveObject {
  Sale({
    required this.productName,
    required this.costPrice,
    required this.defaultSellingPrice,
    required this.actualSellingPrice,
    required this.quantitySold,
    required this.discountPerItem,
    required this.totalSale,
    required this.totalProfit,
    required this.saleDate,
  });

  @HiveField(0)
  String productName;

  @HiveField(1)
  double costPrice;

  @HiveField(2)
  double defaultSellingPrice;

  @HiveField(3)
  double actualSellingPrice;

  @HiveField(4)
  int quantitySold;

  @HiveField(5)
  double discountPerItem;

  @HiveField(6)
  double totalSale;

  @HiveField(7)
  double totalProfit;

  @HiveField(8)
  DateTime saleDate;
}
