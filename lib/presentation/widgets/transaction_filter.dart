import 'package:flutter/material.dart';

class TransactionFilter extends StatefulWidget {
  final Function(bool?) onFilterChanged;

  TransactionFilter({required this.onFilterChanged});

  @override
  _TransactionFilterState createState() => _TransactionFilterState();
}

class _TransactionFilterState extends State<TransactionFilter> {
  bool? _filter;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<bool?>(
      value: _filter,
      hint: Text('Фильтр'),
      items: [
        DropdownMenuItem(child: Text('Все'), value: null),
        DropdownMenuItem(child: Text('Доходы'), value: true),
        DropdownMenuItem(child: Text('Расходы'), value: false),
      ],
      onChanged: (value) {
        setState(() => _filter = value);
        widget.onFilterChanged(value);
      },
    );
  }
}