import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_bloc.dart';
import '../widgets/transaction_list.dart';
import '../widgets/balance_chart.dart';
import '../widgets/transaction_filter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? _filter; // null = все, true = доходы, false = расходы

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Личные финансы')),
      body: Column(
        children: [
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoaded) {
                double totalBalance = state.transactions.fold(0, (sum, item) => item.isIncome ? sum + item.amount : sum - item.amount);
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Общий баланс: ${totalBalance.toStringAsFixed(2)} ₽',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Общий баланс: 0 ₽',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          TransactionFilter(
            onFilterChanged: (bool? filter) {
              setState(() {
                _filter = filter;
              });
            },
          ),
          BalanceChart(),
          Expanded(
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoaded) {
                  final filteredTransactions = _filter == null
                      ? state.transactions
                      : state.transactions.where((tx) => tx.isIncome == _filter).toList();
                  return TransactionList(transactions: filteredTransactions);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_transaction');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}