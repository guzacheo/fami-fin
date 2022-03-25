import 'package:fami_fin/data/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;

  const TransactionWidget(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 1, top: 5, right: 1, bottom: 2),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(top: 1, bottom: 1),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[350]!,
                        blurRadius: 6.0,
                        offset: const Offset(0, 2.0))
                  ],
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.amber[600],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(Icons.car_repair,
                          color: Colors.white, size: 24),
                    ),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction.description,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text('Categoria',
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 13.0))
                          ]),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'R\$ ' +
                                (transaction.valueInCents ~/ 100).toString() +
                                ',' +
                                (transaction.valueInCents % 100).toString().padLeft(2, '0'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.orange),
                          ),
                          Text(DateFormat('dd/MM/yy').format(transaction.date).toString(),
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12.0))
                        ])
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
