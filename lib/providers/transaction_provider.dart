// providers/transaction_provider.dart
import 'package:buget_app/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  double get totalIncome => _transactions
      .where((transaction) => !transaction.isExpense)
      .fold(0.0, (sum, item) => sum + item.amount);

  double get totalExpenses => _transactions
      .where((transaction) => transaction.isExpense)
      .fold(0.0, (sum, item) => sum + item.amount);

  double get balance => totalIncome - totalExpenses;

  TransactionProvider() {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? transactionsJson = prefs.getString('transactions');

    if (transactionsJson != null) {
      List<dynamic> transactionList = json.decode(transactionsJson);
      _transactions = transactionList
          .map((transaction) => Transaction.fromMap(transaction))
          .toList();
      notifyListeners();
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
    await saveTransactions();
    notifyListeners();
  }

  Future<void> removeTransaction(String id) async {
    _transactions.removeWhere((transaction) => transaction.id == id);
    await saveTransactions();
    notifyListeners();
  }

  Future<void> saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String transactionsJson =
        json.encode(_transactions.map((t) => t.toMap()).toList());
    await prefs.setString('transactions', transactionsJson);
  }
}
