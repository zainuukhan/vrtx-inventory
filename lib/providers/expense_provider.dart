import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/expense.dart';
import '../database/hive_database.dart';

final expenseBoxProvider = Provider<Box<Expense>>((ref) {
  return Hive.box<Expense>(HiveDatabase.expenseBox);
});

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>((
  ref,
) {
  final box = ref.read(expenseBoxProvider);
  return ExpenseNotifier(box);
});

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  final Box<Expense> box;

  ExpenseNotifier(this.box) : super(box.values.toList());

  void addExpense(Expense expense) {
    box.add(expense);
    state = box.values.toList(); // sync UI with storage
  }

  double get totalExpenses => state.fold(0, (sum, item) => sum + item.amount);
}
