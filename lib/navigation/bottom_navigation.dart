import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/expenses/expenses_screen.dart';
import '../screens/products/products_screen.dart';
import '../screens/sales/sales_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  final pages = const [
    DashboardScreen(),
    ProductsScreen(),
    CartScreen(),
    SalesScreen(),
    ExpenseScreen(),
  ];

  final icons = [
    Icons.dashboard_rounded,
    Icons.inventory_2_rounded,
    Icons.shopping_cart_rounded,
    Icons.receipt_long_rounded,
    Icons.payments_rounded,
  ];

  final labels = ["Home", "Products", "Cart", "Sales", "Expenses"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            14,
            0,
            14,
            18,
          ), // Slightly reduced side padding
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.45),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(icons.length, (index) {
                final selected = currentIndex == index;

                // Wrap each item in Expanded so the row divides space mathematically
                // instead of letting unselected items crowd out the active text.
                return Expanded(
                  flex: selected
                      ? 2
                      : 1, // Active item gets more breathing room
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ), // Prevents pills from touching
                      padding: EdgeInsets.symmetric(
                        horizontal: selected
                            ? 12
                            : 8, // Dynamic padding to save space
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icons[index],
                            color: selected ? Colors.white : Colors.white70,
                            size: 22, // Slightly standardized size
                          ),
                          if (selected) ...[
                            const SizedBox(
                              width: 4,
                            ), // Reduced spacing to prevent overflows
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit
                                    .scaleDown, // Shrinks text slightly if it hits the boundary
                                child: Text(
                                  labels[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
