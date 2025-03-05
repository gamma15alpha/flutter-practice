part of 'transaction_bloc.dart';

abstract class TransactionEvent {}

class LoadTransactions extends TransactionEvent {}

class AddNewTransaction extends TransactionEvent {
  final TransactionModel transaction;
  AddNewTransaction(this.transaction);
}

