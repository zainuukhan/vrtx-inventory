import 'package:flutter/material.dart';

import '../../models/invoice.dart';

class InvoiceDetailsDialog extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetailsDialog({super.key, required this.invoice});

  Widget row(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate 85% of the total screen width
    final dynamicWidth = MediaQuery.of(context).size.width * 0.85;

    return Dialog(
      child: Container(
        // Set the width dynamically based on the device screen size
        width: dynamicWidth,
        constraints: const BoxConstraints(
          maxWidth:
              750, // Prevents the dialog from becoming too wide on large screens/desktop
          minWidth: 360, // Ensures a decent minimum size on very tiny screens
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "INVOICE",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),

                const Divider(height: 30),

                row("Invoice ID", invoice.invoiceId, bold: true),
                row("Customer", invoice.customerName),
                row("Phone", invoice.phone.isEmpty ? "-" : invoice.phone),
                row("Date", invoice.dateTime.toString()),

                const Divider(height: 30),

                const Text(
                  "Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                ...invoice.items.map(
                  (item) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          row("Product", item.productName, bold: true),
                          row("Quantity", item.quantity.toString()),
                          row(
                            "Cost Price",
                            "Rs ${item.costPrice.toStringAsFixed(0)}",
                          ),
                          row(
                            "Selling Price",
                            "Rs ${item.sellingPrice.toStringAsFixed(0)}",
                          ),
                          row(
                            "Profit",
                            "Rs ${item.totalProfit.toStringAsFixed(0)}",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Divider(height: 30),

                row(
                  "Total Sale",
                  "Rs ${invoice.totalSale.toStringAsFixed(0)}",
                  bold: true,
                ),

                row("Total Cost", "Rs ${invoice.totalCost.toStringAsFixed(0)}"),

                row(
                  "Gross Profit",
                  "Rs ${invoice.totalProfit.toStringAsFixed(0)}",
                  bold: true,
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
