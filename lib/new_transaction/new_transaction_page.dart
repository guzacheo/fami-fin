
import 'package:fami_fin/data/transaction.dart';
import 'package:fami_fin/data/transaction_dao.dart';
import 'package:fami_fin/new_transaction/new_transaction_form.dart';
import 'package:flutter/material.dart';

class NewTransactionPageState extends State<NewTransactionPage> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Transação'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: NewTransactionForm(onSaveTransaction: widget.onSaveTransaction)
      )
    );
  }
}
class NewTransactionPage extends StatefulWidget {
  NewTransactionPage({Key? key}) : super(key: key);

  final transactionDao = TransactionDao();
  void onSaveTransaction(Transaction transaction) {
    transactionDao.saveTransaction(transaction);
  }

  @override
  NewTransactionPageState createState() => NewTransactionPageState();
}
