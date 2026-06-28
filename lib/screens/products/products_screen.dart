import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  final searchController = TextEditingController();
  String search = "";

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);

    final filtered = products.where((e) {
      return e.name.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Products",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search product...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text("No Products"))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filtered.length,
                      itemBuilder: (_, index) {
                        final product = filtered[index];

                        Color stockColor;

                        String stockText;

                        if (product.quantity == 0) {
                          stockColor = Colors.red;
                          stockText = "Out of Stock";
                        } else if (product.quantity < 5) {
                          stockColor = Colors.orange;
                          stockText = "Low Stock";
                        } else {
                          stockColor = Colors.green;
                          stockText = "In Stock";
                        }

                        return GestureDetector(
                          onTap: () async {
                            final action = await showModalBottomSheet<String>(
                              context: context,
                              backgroundColor: AppColors.surface,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),
                              ),
                              builder: (_) {
                                return SafeArea(
                                  child: Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.shopping_cart,
                                        ),
                                        title: const Text("Add To Cart"),
                                        onTap: () =>
                                            Navigator.pop(context, "cart"),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.edit),
                                        title: const Text("Edit Product"),
                                        onTap: () =>
                                            Navigator.pop(context, "edit"),
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        title: const Text("Delete Product"),
                                        onTap: () =>
                                            Navigator.pop(context, "delete"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );

                            if (!context.mounted) return;

                            switch (action) {
                              case "cart":
                                if (product.quantity <= 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Out of Stock"),
                                    ),
                                  );
                                  return;
                                }

                                ref
                                    .read(cartProvider.notifier)
                                    .addToCart(product);

                                break;

                              case "edit":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditProductScreen(
                                      product: product,
                                      index: products.indexOf(product),
                                    ),
                                  ),
                                );
                                break;

                              case "delete":
                                ref
                                    .read(productListProvider.notifier)
                                    .deleteProduct(products.indexOf(product));
                                break;
                            }
                          },

                          child: Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: stockColor.withOpacity(.15),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        stockText,
                                        style: TextStyle(
                                          color: stockColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 18),

                                Row(
                                  children: [
                                    Expanded(
                                      child: infoBox(
                                        "Cost",
                                        "Rs ${product.costPrice.toStringAsFixed(0)}",
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: infoBox(
                                        "Selling",
                                        "Rs ${product.defaultSellingPrice.toStringAsFixed(0)}",
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: infoBox(
                                        "Stock",
                                        product.quantity.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text("Add Product"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
        },
      ),
    );
  }

  Widget infoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}
