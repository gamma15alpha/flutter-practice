import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_bloc.dart';
import '../../data/models/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isIncome = true;

  void _submitData() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);
    final transaction = TransactionModel(title: title, amount: amount, isIncome: _isIncome);

    context.read<TransactionBloc>().add(AddNewTransaction(transaction));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавить транзакцию')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Название')),
            TextField(controller: _amountController, decoration: InputDecoration(labelText: 'Сумма'), keyboardType: TextInputType.number),
            SwitchListTile(title: Text('Доход'), value: _isIncome, onChanged: (val) => setState(() => _isIncome = val)),
            ElevatedButton(onPressed: _submitData, child: Text('Добавить'))
          ],
        ),
      ),
    );
  }
}
