import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final bool isIncome;

  TransactionModel({required this.title, required this.amount, required this.isIncome});
}