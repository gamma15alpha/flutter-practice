import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_bloc.dart';

class BalanceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded) {
          double income = state.transactions
              .where((tx) => tx.isIncome)
              .fold(0, (sum, item) => sum + item.amount);
          double expenses = state.transactions
              .where((tx) => !tx.isIncome)
              .fold(0, (sum, item) => sum + item.amount);
          
          return SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: income,
                    title: 'Доход',
                    color: Colors.green,
                  ),
                  PieChartSectionData(
                    value: expenses,
                    title: 'Расход',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}