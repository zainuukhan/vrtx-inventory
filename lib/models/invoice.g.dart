// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceAdapter extends TypeAdapter<Invoice> {
  @override
  final int typeId = 5;

  @override
  Invoice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invoice(
      invoiceId: fields[0] as String,
      customerName: fields[1] as String,
      phone: fields[2] as String,
      dateTime: fields[3] as DateTime,
      items: (fields[4] as List).cast<InvoiceItem>(),
      totalSale: fields[5] as double,
      totalCost: fields[6] as double,
      totalProfit: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.invoiceId)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.items)
      ..writeByte(5)
      ..write(obj.totalSale)
      ..writeByte(6)
      ..write(obj.totalCost)
      ..writeByte(7)
      ..write(obj.totalProfit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
