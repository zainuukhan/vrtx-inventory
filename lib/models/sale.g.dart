// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleAdapter extends TypeAdapter<Sale> {
  @override
  final int typeId = 1;

  @override
  Sale read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sale(
      productName: fields[0] as String,
      costPrice: fields[1] as double,
      defaultSellingPrice: fields[2] as double,
      actualSellingPrice: fields[3] as double,
      quantitySold: fields[4] as int,
      discountPerItem: fields[5] as double,
      totalSale: fields[6] as double,
      totalProfit: fields[7] as double,
      saleDate: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Sale obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.costPrice)
      ..writeByte(2)
      ..write(obj.defaultSellingPrice)
      ..writeByte(3)
      ..write(obj.actualSellingPrice)
      ..writeByte(4)
      ..write(obj.quantitySold)
      ..writeByte(5)
      ..write(obj.discountPerItem)
      ..writeByte(6)
      ..write(obj.totalSale)
      ..writeByte(7)
      ..write(obj.totalProfit)
      ..writeByte(8)
      ..write(obj.saleDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
