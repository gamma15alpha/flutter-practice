import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/transaction_model.dart';
import '../../domain/usecases/add_transaction.dart';
import '../../domain/usecases/get_transactions.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final AddTransaction addTransaction;
  final GetTransactions getTransactions;

  TransactionBloc({required this.addTransaction, required this.getTransactions})
      : super(TransactionInitial()) {
    on<LoadTransactions>((event, emit) async {
      emit(TransactionLoading());
      final transactions = await getTransactions();
      emit(TransactionLoaded(transactions));
    });

    on<AddNewTransaction>((event, emit) async {
      await addTransaction(event.transaction);
      final transactions = await getTransactions();
      emit(TransactionLoaded(transactions));
    });
  }
}
