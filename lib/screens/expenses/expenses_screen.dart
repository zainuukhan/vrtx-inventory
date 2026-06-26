import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expenses")),
      body: const Center(
        child: Text("No Expenses Yet", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
