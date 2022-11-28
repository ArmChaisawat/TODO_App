import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project1/database/transaction_database.dart';
import 'package:uuid/uuid.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> transactionModel = [];
  int? count = 0;
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
    notifyListeners();
  }

  void removeTransaction(int index) async {
    await database.deleteData(transactionModel[index]);
    transactionModel.removeAt(index);
    notifyListeners();
  }

  void onChecked(int index, bool value) async {
    transactionModel[index].value = value;
    await database.updateData(transactionModel[index]);
    notifyListeners();
  }

  dynamic createUuid() {
    const uuid = Uuid();
    return uuid.v1();
  }
}
