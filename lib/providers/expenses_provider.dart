import 'package:flutter/foundation.dart';
import 'package:buget_app/models/expnese_model.dart';

class ExpensesProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses {
    return [..._expenses];
  }

  double get totalExpenses {
    return _expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }
}
