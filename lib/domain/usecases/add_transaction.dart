import '../../data/repositories/transaction_repository.dart';
import '../../data/models/transaction_model.dart';

class AddTransaction {
  final TransactionRepository repository;

  AddTransaction(this.repository);

  Future<void> call(TransactionModel transaction) async {
    await repository.addTransaction(transaction);
  }
}