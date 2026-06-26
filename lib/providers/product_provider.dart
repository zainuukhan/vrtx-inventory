import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../repositories/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productListProvider =
    StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
      return ProductNotifier(ref.read(productRepositoryProvider));
    });

class ProductNotifier extends StateNotifier<List<Product>> {
  final ProductRepository repository;

  ProductNotifier(this.repository) : super([]) {
    loadProducts();
  }

  void loadProducts() {
    state = repository.getProducts();
  }

  Future<void> addProduct(Product product) async {
    await repository.addProduct(product);

    loadProducts();
  }

  Future<void> deleteProduct(int index) async {
    await repository.deleteProduct(index);

    loadProducts();
  }

  Future<void> updateProduct(int index, Product product) async {
    await repository.updateProduct(index, product);

    loadProducts();
  }
}
