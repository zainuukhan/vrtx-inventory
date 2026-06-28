import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/invoice.dart';
import '../../models/invoice_item.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/invoice_provider.dart';
import '../../providers/product_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final customerController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    customerController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String generateInvoiceId() {
    final now = DateTime.now();

    return "INV"
        "${now.year}"
        "${now.month.toString().padLeft(2, '0')}"
        "${now.day.toString().padLeft(2, '0')}"
        "${now.hour.toString().padLeft(2, '0')}"
        "${now.minute.toString().padLeft(2, '0')}"
        "${now.second.toString().padLeft(2, '0')}";
  }

  Future<void> completeSale() async {
    final cart = ref.read(cartProvider);

    if (cart.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Cart is empty")));
      return;
    }

    final productNotifier = ref.read(productListProvider.notifier);

    // Check stock first
    for (final item in cart) {
      final product = productNotifier.getProductById(item.productId);

      if (product == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${item.productName} not found")),
        );
        return;
      }

      if (product.quantity < item.quantity) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Not enough stock for ${product.name}")),
        );
        return;
      }
    }

    // Convert cart to invoice items
    final invoiceItems = cart
        .map(
          (e) => InvoiceItem(
            productId: e.productId,
            productName: e.productName,
            costPrice: e.costPrice,
            sellingPrice: e.sellingPrice,
            quantity: e.quantity,
          ),
        )
        .toList();

    double totalSale = 0;
    double totalCost = 0;
    double totalProfit = 0;

    for (final item in invoiceItems) {
      totalSale += item.totalSale;
      totalCost += item.totalCost;
      totalProfit += item.totalProfit;
    }

    final invoice = Invoice(
      invoiceId: generateInvoiceId(),
      customerName: customerController.text.trim().isEmpty
          ? "Walk-in Customer"
          : customerController.text.trim(),
      phone: phoneController.text.trim(),
      dateTime: DateTime.now(),
      items: invoiceItems,
      totalSale: totalSale,
      totalCost: totalCost,
      totalProfit: totalProfit,
    );

    // Save invoice
    await ref.read(invoiceProvider.notifier).addInvoice(invoice);

    // Deduct stock
    for (final item in cart) {
      final product = productNotifier.getProductById(item.productId)!;

      final updatedProduct = Product(
        id: product.id,
        name: product.name,
        costPrice: product.costPrice,
        defaultSellingPrice: product.defaultSellingPrice,
        quantity: product.quantity - item.quantity,
        createdAt: product.createdAt,
      );

      await productNotifier.updateProductById(updatedProduct);
    }

    // Clear cart
    ref.read(cartProvider.notifier).clearCart();

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Sale Completed Successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    final invoiceId = generateInvoiceId();

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text("Invoice #$invoiceId"),
                subtitle: Text(DateTime.now().toString()),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: customerController,
              decoration: const InputDecoration(
                labelText: "Customer Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            ...cart.map(
              (item) => Card(
                child: ListTile(
                  title: Text(item.productName),
                  subtitle: Text("Qty : ${item.quantity}"),
                  trailing: Text("Rs ${item.totalSale.toStringAsFixed(0)}"),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    summaryRow("Items", cartNotifier.totalItems.toString()),
                    summaryRow(
                      "Sale",
                      "Rs ${cartNotifier.totalSale.toStringAsFixed(0)}",
                    ),
                    summaryRow(
                      "Profit",
                      "Rs ${cartNotifier.totalProfit.toStringAsFixed(0)}",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: completeSale,
                icon: const Icon(Icons.check),
                label: const Text(
                  "Complete Sale",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
