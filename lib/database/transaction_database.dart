import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project1/models/transaction_model.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDatebase {
  String databaseName;

  TransactionDatebase({required this.databaseName});

  Future<Database> openDatabase() async {
    var appDecratory = await getApplicationDocumentsDirectory();
    String databaseLocation = join(appDecratory.path, databaseName);

    DatabaseFactory databaseFactory = databaseFactoryIo;
    Database database = await databaseFactory.openDatabase(databaseLocation);
    return database;
  }

  Future<int> addData(TransactionModel statement) async {
    var database = await openDatabase();
    var store = intMapStoreFactory.store('expense');
    var keyID = store.add(
      database,
      {
        'title': statement.title,
        'value': statement.value,
      },
    );
    database.close();
    return keyID;
  }

  Future loadAllDatabase() async {
    var database = await openDatabase();
    var store = intMapStoreFactory.store('expense');
    var snapshot = await store.find(database);
    List transactionList = <TransactionModel>[];
    for (var record in snapshot) {
      transactionList.add(
        TransactionModel(
          title: record['title'].toString(),
        ),
      );
    }
    return transactionList;
  }
}
