import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'transaction.dart';


class TransactionDao {
  final DatabaseReference _transactionsRef =
  FirebaseDatabase.instance.reference().child('transactions');

  void saveTransaction(Transaction transaction) {
    _transactionsRef.push().set(transaction.toJson());
  }

  Query getTransactionQuery() {
    return _transactionsRef;
  }

  Transaction transactionBuilder(BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
    return Transaction.fromSnapshot(snapshot.key, snapshot.value);
  }
}