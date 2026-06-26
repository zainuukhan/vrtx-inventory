import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product.dart';
import '../../providers/product_provider.dart';

class EditProductScreen extends ConsumerStatefulWidget {
  final Product product;
  final int index;

  const EditProductScreen({
    super.key,
    required this.product,
    required this.index,
  });

  @override
  ConsumerState<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends ConsumerState<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _costController;
  late final TextEditingController _sellingController;
  late final TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.product.name);

    _costController = TextEditingController(
      text: widget.product.costPrice.toString(),
    );

    _sellingController = TextEditingController(
      text: widget.product.sellingPrice.toString(),
    );

    _quantityController = TextEditingController(
      text: widget.product.quantity.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    _sellingController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _updateProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final updated = Product(
      name: _nameController.text.trim(),
      costPrice: double.parse(_costController.text),
      sellingPrice: double.parse(_sellingController.text),
      quantity: int.parse(_quantityController.text),
      createdAt: widget.product.createdAt,
    );

    await ref
        .read(productListProvider.notifier)
        .updateProduct(widget.index, updated);

    if (!mounted) return;

    Navigator.pop(context);
  }

  InputDecoration decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: decoration("Product Name"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _costController,
                keyboardType: TextInputType.number,
                decoration: decoration("Cost Price"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sellingController,
                keyboardType: TextInputType.number,
                decoration: decoration("Selling Price"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: decoration("Quantity"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: _updateProduct,
                  child: const Text(
                    "UPDATE PRODUCT",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
