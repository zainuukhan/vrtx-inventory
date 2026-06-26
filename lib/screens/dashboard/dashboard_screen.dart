import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget infoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VRTX Inventory")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            infoCard("Today's Sales", "Rs. 0", Icons.sell),
            const SizedBox(height: 12),
            infoCard("Gross Profit", "Rs. 0", Icons.trending_up),
            const SizedBox(height: 12),
            infoCard("Net Profit", "Rs. 0", Icons.account_balance_wallet),
            const SizedBox(height: 12),
            infoCard("Products", "0", Icons.inventory),
          ],
        ),
      ),
    );
  }
}
