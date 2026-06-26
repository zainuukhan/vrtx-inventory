import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/product_provider.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: products.isEmpty
          ? const Center(
              child: Text("No Products Yet", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EditProductScreen(product: product, index: index),
                        ),
                      );
                    },
                    title: Text(product.name),
                    subtitle: Text(
                      "Stock: ${product.quantity}\n"
                      "Cost: Rs ${product.costPrice}\n"
                      "Selling: Rs ${product.sellingPrice}",
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final delete = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Delete Product"),
                            content: const Text(
                              "Are you sure you want to delete this product?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Delete"),
                              ),
                            ],
                          ),
                        );

                        if (delete == true) {
                          ref
                              .read(productListProvider.notifier)
                              .deleteProduct(index);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
        },
      ),
    );
  }
}
