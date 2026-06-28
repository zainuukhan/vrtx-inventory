import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _costController = TextEditingController();
  final _sellingController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    _sellingController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final uuid = Uuid();

    final product = Product(
      id: uuid.v4(),
      name: _nameController.text.trim(),
      costPrice: double.parse(_costController.text),
      defaultSellingPrice: double.parse(_sellingController.text),
      quantity: int.parse(_quantityController.text),
      createdAt: DateTime.now(),
    );

    await ref.read(productListProvider.notifier).addProduct(product);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Product Added Successfully")));

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
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: decoration("Product Name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter product name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _costController,
                keyboardType: TextInputType.number,
                decoration: decoration("Cost Price"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter cost price";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _sellingController,
                keyboardType: TextInputType.number,
                decoration: decoration("Selling Price"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter selling price";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: decoration("Quantity"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter quantity";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: _saveProduct,
                  child: const Text(
                    "SAVE PRODUCT",
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
