import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = recentTransactions
          .where((element) =>
              element.date.day == weekDay.day &&
              element.date.month == weekDay.month &&
              element.date.year == weekDay.year)
          .map((tx) => tx.amount)
          .fold(0, (v1, v2) => v1 + v2);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupTransactionValues.fold(
        0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues
              .map((data) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        data['day'],
                        data['amount'],
                        totalSpending == 0.0
                            ? 0.0
                            : (data['amount'] as double) / totalSpending),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
