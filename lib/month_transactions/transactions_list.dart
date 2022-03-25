import 'package:fami_fin/month_transactions/transaction_widget.dart';
import 'package:fami_fin/new_transaction/new_transaction_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/transaction_dao.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';

class TransactionListState extends State<TransactionList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      appBar: AppBar(
        title: const Text('FamiFin - Transações no Mês'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _getTransactionList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTransactionPage()),
          )
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  // void _sendTransaction() {
  //   final data =
  //       Transaction(_transactionController.text, DateTime.now(), 12300);
  //   widget.transactionDao.saveTransaction(data);
  //   _transactionController.clear();
  //   setState(() {});
  // }

  Widget _getTransactionList() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.transactionDao.getTransactionQuery(),
        itemBuilder: (context, snapshot, animation, index) => TransactionWidget(widget.transactionDao.transactionBuilder(context, snapshot, animation, index)),
      ),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}

class TransactionList extends StatefulWidget {
  TransactionList({Key? key}) : super(key: key);

  final transactionDao = TransactionDao();

  @override
  TransactionListState createState() => TransactionListState();
}
