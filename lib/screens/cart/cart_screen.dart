import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/cart_item_tile.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: cart.isEmpty
            ? const Center(
                child: Text(
                  "Your Cart is Empty",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            : Column(
                children: [
                  const SizedBox(height: 20),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Shopping Cart",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cart.length,
                      itemBuilder: (_, index) {
                        final item = cart[index];

                        return CartItemTile(
                          item: item,
                          onAdd: () => cartNotifier.increase(index),
                          onRemove: () => cartNotifier.decrease(index),
                          onDelete: () => cartNotifier.remove(index),
                          onPriceChanged: (price) {
                            cartNotifier.updateSellingPrice(index, price);
                          },
                        );
                      },
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(18),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        summaryRow("Items", cartNotifier.totalItems.toString()),

                        const SizedBox(height: 10),

                        summaryRow(
                          "Sale",
                          "Rs ${cartNotifier.totalSale.toStringAsFixed(0)}",
                        ),

                        const SizedBox(height: 10),

                        summaryRow(
                          "Profit",
                          "Rs ${cartNotifier.totalProfit.toStringAsFixed(0)}",
                        ),

                        const SizedBox(height: 22),

                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CheckoutScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Proceed to Checkout",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget summaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ],
    );
  }
}
