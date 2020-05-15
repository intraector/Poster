import 'dart:async';
import 'dart:io';

import 'package:Poster/services/sqlite/sqlite_fields.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Poster/constants/app_settings.dart';
import 'package:Poster/services/sqlite/sqlite_tables.dart';

class SrvcSqliteInit {
  //-----------------------------------------
  Future<void> init() async {
    var _completer = Completer();
    initComplete = _completer.future;
    path = await getDatabasesPath();
    path = join(path, 'db.db');
    // await deleteDb();
    db = await openDb(path);
    _completer.complete();
  }

  Future<void> initComplete;
  Database db;
  String path;

  //-----------------------------------------
  Future<void> deleteDb() async {
    if (db != null) {
      await db.close();
      db = null;
    }
    if (await File(path).exists()) {
      return File(path).delete();
    } else {
      return Future.value(null);
    }
  }

  //-----------------------------------------
  Future<void> createPostsTable(Database db) => db.execute('''
            CREATE TABLE IF NOT EXISTS ${SqliteTable.posts} (
              autoId INTEGER PRIMARY KEY,
              ${SqliteFieldsPosts.id} INTEGER,
              ${SqliteFieldsPosts.title} TEXT TEXT,
              ${SqliteFieldsPosts.body} TEXT,
              ${SqliteFieldsPosts.userId} INTEGER
            )''');

//-----------------------------------------
  Future<Database> openDb(String path) => openDatabase(
        path,
        version: AppSettings.appVersionInt,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        singleInstance: true,
      );

//-----------------------------------------
  Future<void> _onCreate(Database db, int version) async {
    await createPostsTable(db);
    return null;
  }

//-----------------------------------------
  Future<void> _onUpgrade(Database db, int _oldVersion, int _newVersion) {
    return null;
  }
}
