import 'package:flutter/foundation.dart';
import 'package:flutter_application_2/databases/TransactionDB.dart';
import 'package:flutter_application_2/models/TransactionItem.dart';
import 'package:sembast/sembast.dart';

class TransactionProvider with ChangeNotifier {
  String dbName = "Transaction2.db";
  List<TransactionItem> transactions = [];

  List<TransactionItem> getTransaction() {
    return transactions;
  }

  void addTransaction(TransactionItem trans) async {
    TransactionDB db = TransactionDB('dbName');
    int keyId = await db.insertData(trans);

    transactions = await db.loadAllData();

    // transactions.add(trans);
    // transactions.insert(0, trans);
    notifyListeners();
  }

  Future<List<TransactionItem>> loadAllData() async {
    TransactionDB db = TransactionDB('dbName');
    return await db.loadAllData();
  }

  void ininAlldata() async {
    TransactionDB db = TransactionDB('dbName');

    transactions = await db.loadAllData();
    notifyListeners();
  }

  deleteData(TransactionItem trans) async {
    TransactionDB db = TransactionDB('dbName');
    await db.deleteData(trans);
  }

  updateTransaction(TransactionItem trans) async {
    TransactionDB db = TransactionDB('dbName');
    await db.updateData(trans);
    notifyListeners();
  }
}
