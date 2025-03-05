import 'package:hive/hive.dart';
import '../models/transaction_model.dart';
import '../../core/app_constants.dart';

class TransactionRepository {
  Future<void> addTransaction(TransactionModel transaction) async {
    final box = await Hive.openBox<TransactionModel>(AppConstants.transactionBox);
    await box.add(transaction);
  }

  Future<List<TransactionModel>> getTransactions() async {
    final box = await Hive.openBox<TransactionModel>(AppConstants.transactionBox);
    return box.values.toList();
  }
}
