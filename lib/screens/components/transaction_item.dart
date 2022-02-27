import 'package:flutter/material.dart';
import 'package:lamborghini/model/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key, required this.transaction})
      : super(key: key);
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.indigo,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  transaction.itemName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  transaction.transactionDate,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(
              transaction.transactionType == "Redemption"
                  ? "- ${transaction.points.toStringAsFixed(0)}"
                  : "+ ${transaction.points.toStringAsFixed(0)}",
              style: TextStyle(
                color: transaction.transactionType == "Redemption"
                    ? Colors.red
                    : Colors.green,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
