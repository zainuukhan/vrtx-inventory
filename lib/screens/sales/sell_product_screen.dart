import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/product.dart';
import '../../models/sale.dart';
import '../../providers/product_provider.dart';
import '../../providers/sale_provider.dart';

class SellProductScreen extends ConsumerStatefulWidget {
  final Product product;
  final int index;

  const SellProductScreen({
    super.key,
    required this.product,
    required this.index,
  });

  @override
  ConsumerState<SellProductScreen> createState() => _SellProductScreenState();
}

class _SellProductScreenState extends ConsumerState<SellProductScreen> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> sellProduct() async {
    final qty = int.tryParse(quantityController.text);
    final actualPrice = double.tryParse(priceController.text);

    if (qty == null || qty <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter valid quantity")));
      return;
    }

    if (actualPrice == null || actualPrice <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter valid price")));
      return;
    }

    if (qty > widget.product.quantity) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Not enough stock")));
      return;
    }

    final defaultPrice = widget.product.defaultSellingPrice;
    final costPrice = widget.product.costPrice;

    final discountPerItem = actualPrice < defaultPrice
        ? (defaultPrice - actualPrice)
        : 0.0;

    final totalSale = actualPrice * qty;
    final totalCost = costPrice * qty;
    final totalProfit = totalSale - totalCost;

    final sale = Sale(
      productName: widget.product.name,
      costPrice: costPrice,
      defaultSellingPrice: defaultPrice,
      actualSellingPrice: actualPrice,
      quantitySold: qty,
      discountPerItem: discountPerItem,
      totalSale: totalSale,
      totalProfit: totalProfit,
      saleDate: DateTime.now(),
    );

    await ref.read(saleProvider.notifier).addSale(sale);

    final updatedProduct = Product(
      id: widget.product.id,
      name: widget.product.name,
      costPrice: widget.product.costPrice,
      defaultSellingPrice: widget.product.defaultSellingPrice,
      quantity: widget.product.quantity - qty,
      createdAt: widget.product.createdAt,
    );

    await ref
        .read(productListProvider.notifier)
        .updateProduct(widget.index, updatedProduct);

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Sale Recorded")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sell Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(widget.product.name),
                subtitle: Text(
                  "Stock: ${widget.product.quantity}\n"
                  "Price: ${widget.product.defaultSellingPrice}",
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Selling Price (per item)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: sellProduct,
                child: const Text(
                  "SELL PRODUCT",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
