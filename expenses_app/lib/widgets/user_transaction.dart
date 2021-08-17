import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 43.39,
        date: DateTime.now()),
  ];

  void _addNewTransaction(
      {@required String trTitle, @required double trAmount}) {
    final newTr = Transaction(
        id: DateTime.now().toString(),
        title: trTitle,
        amount: trAmount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(newTr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      NewTransaction(_addNewTransaction),
      TransactionList(_userTransactions)
    ]);
  }
}
