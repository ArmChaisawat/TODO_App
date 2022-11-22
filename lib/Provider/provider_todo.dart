import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project1/database/transaction_database.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> transactionModel = [];
  int? count = 0;
  TransactionModel data = TransactionModel(title: '');
  var database = TransactionDatebase(databaseName: 'Transaction.database');

  List<TransactionModel> getTransaction() {
    return transactionModel;
  }

  double getCount() {
    count = transactionModel.where((e) => e.value == true).length;
    return count?.toDouble() ?? 0;
  }

  double getPercent() {
    return getCount() / transactionModel.length;
  }

  void initData() async {
    transactionModel = await database.loadAllDatabase();
    notifyListeners();
  }

  void addTransaction(TransactionModel statement) async {
    transactionModel.add(statement);
    await database.addData(statement);
    transactionModel = await database.loadAllDatabase();
    notifyListeners();
  }

  void removeTransaction(int index) async {
    data = transactionModel[index];
    await database.deleteData(transactionModel[index]);
    transactionModel.removeAt(index);

    // await database.addAllData(transactionModel);
    transactionModel = await database.loadAllDatabase();
    notifyListeners();
  }

  void onChecked(int index, bool value) {
    transactionModel[index].value = value;
    notifyListeners();
  }
}
