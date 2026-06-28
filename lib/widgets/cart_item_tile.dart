import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../models/cart_item.dart';

class CartItemTile extends StatefulWidget {
  final CartItem item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;
  final ValueChanged<double> onPriceChanged;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
    required this.onPriceChanged,
  });

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();

    priceController = TextEditingController(
      text: widget.item.sellingPrice.toStringAsFixed(0),
    );
  }

  @override
  void didUpdateWidget(covariant CartItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.item.sellingPrice != widget.item.sellingPrice) {
      priceController.text = widget.item.sellingPrice.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          /// Header
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.inventory_2,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.productName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Cost Rs ${widget.item.costPrice.toStringAsFixed(0)}",
                      style: const TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: widget.onDelete,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Selling Price
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: "Rs ",
              labelText: "Selling Price",
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              final price = double.tryParse(value);

              if (price != null && price > 0) {
                widget.onPriceChanged(price);
              }
            },
          ),

          const SizedBox(height: 20),

          /// Quantity Controls
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: widget.onRemove,
                        icon: const Icon(Icons.remove),
                      ),

                      Text(
                        widget.item.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: widget.onAdd,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Profit",
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Rs ${widget.item.profit.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Subtotal",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                Text(
                  "Rs ${widget.item.totalSale.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
