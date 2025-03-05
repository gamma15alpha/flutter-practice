import 'package:bloc_demo/data/models/transaction_model.dart';
import 'package:bloc_demo/presentation/screens/add_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc_demo/presentation/screens/home_screen.dart';
import 'package:bloc_demo/presentation/bloc/transaction_bloc.dart';
import 'package:bloc_demo/data/repositories/transaction_repository.dart';
import 'package:bloc_demo/domain/usecases/add_transaction.dart';
import 'package:bloc_demo/domain/usecases/get_transactions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  await Hive.openBox<TransactionModel>('transactions');

  final repository = TransactionRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final TransactionRepository repository;
  MyApp({required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(
        addTransaction: AddTransaction(repository),
        getTransactions: GetTransactions(repository),
      )..add(LoadTransactions()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          '/add_transaction': (context) => AddTransactionScreen(),
        },
      ),
    );
  }
}