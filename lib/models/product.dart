import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double costPrice;

  @HiveField(3)
  double defaultSellingPrice;

  @HiveField(4)
  int quantity;

  @HiveField(5)
  DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.costPrice,
    required this.defaultSellingPrice,
    required this.quantity,
    required this.createdAt,
  });
}
