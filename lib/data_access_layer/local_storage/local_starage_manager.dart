import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:sembast/sembast_io.dart';

class LocalStorageManager {
  Database? _database;
  Future<Database> get _db async {
    return _database ?? await _createDatabase();
  }

  LocalStorageManager._shared() {
    _createDatabase();
  }

  static final LocalStorageManager shared = LocalStorageManager._shared();

  Future<Database> _createDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    // make sure it exists
    await dir.create(recursive: true);
    // build the database path
    final dbPath = join(dir.path, 'my_database.db');
    // open the database
    final db = await databaseFactoryIo.openDatabase(dbPath);
    return db;
  }

  save(String recordName, Map<String, dynamic> json) async {
    final store = StoreRef<String, dynamic>.main();
    final db = await _db;
    store.record(recordName).put(db, json);
  }

  Future<Map<String, dynamic>?> get(String recordName) async {
    final store = StoreRef<String, dynamic>.main();
    final db = await _db;
    return await store.record(recordName).get(db);
  }

  delete(String recordName) async {
    final store = StoreRef<String, dynamic>.main();
    final db = await _db;
    store.record(recordName).delete(db);
  }
}
