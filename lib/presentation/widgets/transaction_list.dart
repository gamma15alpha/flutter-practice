import 'package:flutter/material.dart';
import '../../data/models/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;
  
  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(child: Text('Нет транзакций'))
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(transaction.title),
                  subtitle: Text('${transaction.amount.toStringAsFixed(2)} ₽'),
                  trailing: Icon(
                    transaction.isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                    color: transaction.isIncome ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
  }
}