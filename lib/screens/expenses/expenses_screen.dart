import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/expense.dart';
import '../../providers/expense_provider.dart';

class ExpenseScreen extends ConsumerStatefulWidget {
  const ExpenseScreen({super.key});

  @override
  ConsumerState<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends ConsumerState<ExpenseScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void addExpense() {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text);

    if (title.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter valid expense")));
      return;
    }

    final expense = Expense(title: title, amount: amount, date: DateTime.now());

    ref.read(expenseProvider.notifier).addExpense(expense);

    titleController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(expenseProvider);
    final totalExpenses = ref.watch(expenseProvider.notifier).totalExpenses;

    return Scaffold(
      appBar: AppBar(title: const Text("Expenses")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Expense Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addExpense,
                child: const Text("Add Expense"),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Total Expenses: Rs. $totalExpenses",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (_, index) {
                  final e = expenses[index];
                  return ListTile(
                    title: Text(e.title),
                    trailing: Text("Rs ${e.amount}"),
                    subtitle: Text(e.date.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
