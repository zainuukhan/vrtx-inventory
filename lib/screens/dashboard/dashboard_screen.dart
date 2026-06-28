import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/action_button.dart';
import '../../core/widgets/dashboard_header.dart';
import '../../core/widgets/stat_card.dart';

import '../../providers/expense_provider.dart';
import '../../providers/invoice_provider.dart';
import '../../providers/product_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices = ref.watch(invoiceProvider);
    final products = ref.watch(productListProvider);
    final expenses = ref.watch(expenseProvider);

    final totalSales = invoices.fold<double>(0, (sum, e) => sum + e.totalSale);

    final grossProfit = invoices.fold<double>(
      0,
      (sum, e) => sum + e.totalProfit,
    );

    final totalExpenses = expenses.fold<double>(0, (sum, e) => sum + e.amount);

    final netProfit = grossProfit - totalExpenses;

    final inventoryValue = products.fold<double>(
      0,
      (sum, e) => sum + (e.costPrice * e.quantity),
    );

    final lowStock = products.where((e) => e.quantity <= 5).length;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),

              const SizedBox(height: 28),

              const Text(
                "Business Overview",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 18),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: .95,
                children: [
                  StatCard(
                    title: "Revenue",
                    value: "Rs ${totalSales.toStringAsFixed(0)}",
                    icon: Icons.payments,
                    color: Colors.green,
                  ),

                  StatCard(
                    title: "Profit",
                    value: "Rs ${grossProfit.toStringAsFixed(0)}",
                    icon: Icons.trending_up,
                    color: Colors.orange,
                  ),

                  StatCard(
                    title: "Expenses",
                    value: "Rs ${totalExpenses.toStringAsFixed(0)}",
                    icon: Icons.money_off,
                    color: Colors.red,
                  ),

                  StatCard(
                    title: "Net Profit",
                    value: "Rs ${netProfit.toStringAsFixed(0)}",
                    icon: Icons.account_balance_wallet,
                    color: Colors.blue,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Inventory",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff1E1E1E),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    inventoryRow(
                      Icons.inventory_2,
                      "Products",
                      products.length.toString(),
                    ),

                    const Divider(height: 30),

                    inventoryRow(
                      Icons.warning_amber_rounded,
                      "Low Stock",
                      lowStock.toString(),
                    ),

                    const Divider(height: 30),

                    inventoryRow(
                      Icons.store,
                      "Inventory Value",
                      "Rs ${inventoryValue.toStringAsFixed(0)}",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Quick Actions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  ActionButton(
                    icon: Icons.add_box,
                    title: "Product",
                    onTap: () {},
                  ),

                  const SizedBox(width: 14),

                  ActionButton(
                    icon: Icons.point_of_sale,
                    title: "Sale",
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  ActionButton(
                    icon: Icons.money_off,
                    title: "Expense",
                    onTap: () {},
                  ),

                  const SizedBox(width: 14),

                  ActionButton(
                    icon: Icons.analytics,
                    title: "Reports",
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget inventoryRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.red),

        const SizedBox(width: 14),

        Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),

        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ],
    );
  }
}
