import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transaction = [];
  int? count = 0;

  List<Transaction> getTransaction() {
    return transaction;
  }

  double doneCount() {
    return getCount() / transaction.length;
  }

  double getCount() {
    count = transaction.where((e) => e.value == true).length;
    return count?.toDouble() ?? 0;
  }

  double getPercent() {
    return getCount() / transaction.length;
  }

  void addTransaction(Transaction statement) {
    transaction.add(statement);
    notifyListeners();
  }

  void removeTransaction(int index) {
    transaction.removeAt(index);
    notifyListeners();
  }

  void onChecked(int index, bool value) {
    transaction[index].value = value;
    notifyListeners();
  }
}
