import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    final index = state.indexWhere((e) => e.productId == product.id);

    if (index != -1) {
      final updated = [...state];

      updated[index].quantity++;

      state = updated;

      return;
    }

    state = [
      ...state,
      CartItem(
        productId: product.id,
        productName: product.name,
        costPrice: product.costPrice,
        sellingPrice: product.defaultSellingPrice,
        quantity: 1,
      ),
    ];
  }

  void increase(int index) {
    final updated = [...state];

    updated[index].quantity++;

    state = updated;
  }

  void updateSellingPrice(int index, double price) {
    final updated = [...state];

    updated[index].sellingPrice = price;

    state = updated;
  }

  void decrease(int index) {
    final updated = [...state];

    if (updated[index].quantity > 1) {
      updated[index].quantity--;
    }

    state = updated;
  }

  void remove(int index) {
    final updated = [...state];

    updated.removeAt(index);

    state = updated;
  }

  void clearCart() {
    state = [];
  }

  double get totalSale => state.fold(0, (sum, item) => sum + item.totalSale);

  double get totalProfit => state.fold(0, (sum, item) => sum + item.profit);

  int get totalItems => state.fold(0, (sum, item) => sum + item.quantity);
}
