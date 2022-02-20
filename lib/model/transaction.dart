class Transaction {
  final String itemName;
  final String customer;
  final double points;
  final String transactionType;
  final String transactionDate;

  Transaction({
    required this.itemName,
    required this.customer,
    required this.points,
    required this.transactionType,
    required this.transactionDate,
  });

  factory Transaction.fromJson(Map<String, dynamic> item) {
    return Transaction(
      itemName: item["itemName"],
      customer: item["customer"],
      points: item["points"],
      transactionType: item["transactionType"],
      transactionDate: item["transactionDate"],
    );
  }

  Map<String, dynamic> toMap(Transaction transaction) {
    return {
      "itemName": transaction.itemName,
      "customer": transaction.customer,
      "points": transaction.points,
      "transactionType": transaction.transactionType,
      "transactionDate": transaction.transactionDate,
    };
  }
}
