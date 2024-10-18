import 'package:buget_app/models/transaction_model.dart';
import 'package:buget_app/providers/transaction_provider.dart';
import 'package:buget_app/widgets/format_rupiah.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isExpense = true;

  void _addTransaction() {
    final String title = _titleController.text;
    final double? amount = double.tryParse(_amountController.text);

    if (title.isNotEmpty && amount != null) {
      final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now(),
        isExpense: _isExpense,
      );
      Provider.of<TransactionProvider>(context, listen: false)
          .addTransaction(newTransaction);

      _titleController.clear();
      _amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0XFFECF7FF),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _showAddTransactionDialog,
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: const Color(0XFFCBECFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/ic-plus.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFCBECFF),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Personal Finance',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formatRupiah(transactionProvider.balance),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF34B6FF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0XFFCBECFF),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Pemasukan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0XFFB4CDFF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          formatRupiah(transactionProvider.totalIncome),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0XFFCBECFF),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Pengeluaran',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0XFFFFD4A0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          formatRupiah(transactionProvider.totalExpenses),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
            const Text(
              'Transaksi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // ListView untuk transaksi
            ...transactionProvider.transactions.map((transaction) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: transaction.isExpense
                        ? const Color(0XFFFFD4A0)
                        : const Color(0XFFCBECFF),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: transaction.isExpense
                            ? const Color(0XFFFFD4A0)
                            : const Color(0XFFA0F4FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        transaction.isExpense
                            ? 'assets/arrow-up.png'
                            : 'assets/arrow-down.png',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transaction.title),
                          Text(
                            formatRupiah(transaction.amount),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<TransactionProvider>(context, listen: false)
                            .removeTransaction(transaction.id);
                      },
                    ),
                  ],
                ),
              );
            }),

            //
          ],
        ),
      ),
    );
  }

  void _showAddTransactionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Transaksi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Jumlah'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<bool>(
              value: _isExpense,
              items: const [
                DropdownMenuItem<bool>(
                  value: true,
                  child: Text('Pengeluaran'),
                ),
                DropdownMenuItem<bool>(
                  value: false,
                  child: Text('Pemasukan'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _isExpense = value;
                  });
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _addTransaction();
              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
