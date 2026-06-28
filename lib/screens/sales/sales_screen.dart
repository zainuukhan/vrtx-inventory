import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'invoice_details_dialog.dart';
import '../../providers/invoice_provider.dart';

class SalesScreen extends ConsumerWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices = ref.watch(invoiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Invoices")),
      body: invoices.isEmpty
          ? const Center(
              child: Text("No Invoices Yet", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: invoices.length,
              itemBuilder: (_, index) {
                final invoice = invoices[index];

                return Card(
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => InvoiceDetailsDialog(invoice: invoice),
                      );
                    },
                    leading: CircleAvatar(
                      child: Text("${invoice.items.length}"),
                    ),
                    title: Text(invoice.customerName),
                    subtitle: Text(
                      "${invoice.invoiceId}\n"
                      "${invoice.dateTime}",
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rs ${invoice.totalSale.toStringAsFixed(0)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${invoice.items.length} items",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
