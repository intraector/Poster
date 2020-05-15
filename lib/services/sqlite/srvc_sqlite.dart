import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Poster/services/sqlite/sqlite_tables.dart';
import 'package:Poster/core/exceptions/e_insert_entry.dart';
import 'package:Poster/services/sqlite/srvc_sqlite_init.dart';

final getIt = GetIt.instance;

class SrvcSqlite {
  SrvcSqlite() {
    final init = getIt<SrvcSqliteInit>();
    initComplete = init.initComplete;
    initComplete.whenComplete(() {
      db = init.db;
    });
  }

  Future<void> initComplete;
  Database db;

  //-----------------------------------------
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    await initComplete;
    return db.query(SqliteTable.posts);
  }

  //-----------------------------------------
  Future<bool> savePosts(Iterable<Map<String, dynamic>> posts) async {
    await initComplete;
    var batch = db.batch();
    for (var post in posts)
      batch.insert(SqliteTable.posts, post, conflictAlgorithm: ConflictAlgorithm.replace);
    var results = await batch.commit();
    if (results.any((result) => result <= 0)) throw EInsertPost('Can\'t insert SrvcSqlite');
    return true;
  }

  //-----------------------------------------
  Future<void> remove(String uid) async {
    await initComplete;
    db.delete(
      SqliteTable.posts,
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }
}
