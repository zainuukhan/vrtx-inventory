import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  Product({
    required this.name,
    required this.costPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.createdAt,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  double costPrice;

  @HiveField(2)
  double sellingPrice;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  DateTime createdAt;
}
