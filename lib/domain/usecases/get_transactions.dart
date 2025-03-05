import '../../data/repositories/transaction_repository.dart';
import '../../data/models/transaction_model.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<List<TransactionModel>> call() async {
    return await repository.getTransactions();
  }
}