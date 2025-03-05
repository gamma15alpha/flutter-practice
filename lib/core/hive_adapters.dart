import 'package:bloc_demo/data/models/transaction_model.dart';
import 'package:hive/hive.dart';

void registerHiveAdapters() {
  Hive.registerAdapter(TransactionModelAdapter());
}
