import 'package:buget_app/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
      child: MaterialApp(
        title: 'Aplikasi Pengelolaan Anggaran',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SplashPage(),
      ),
    );
  }
}
