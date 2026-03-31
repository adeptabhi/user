// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:adept_log/view/adept_log.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:user/local_db/db_table_name.dart';

class DB {
  final String _dbName = 'userApp.db';
  int version = 1;
  Database? db;
  static final DB inst = DB();

  Future<void> openDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    db = await openDatabase(
      path,
      version: version,
      onCreate: (Database db, int version) async {
        this.db = db;
        List<String> tables = [
          "${DBTableName.users}( id INTEGER PRIMARY KEY,name TEXT,username TEXT,email TEXT,address TEXT,phone TEXT,website TEXT,company TEXT,UNIQUE(id))",
        ];
        await batchCreateTable(tables);
      },
    );
    AdeptLog.i('${directory.path}/$_dbName', tag: "Path");
  }

  Future<Database> getDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    db = await openDatabase(path, version: version);
    return db!;
  }

  Future createTable(String sqlQuery) async {
    try {
      await db!.execute(sqlQuery);
      AdeptLog.i("Created", tag: _getTableName(sqlQuery));
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
      rethrow;
    }
  }

  Future<void> batchCreateTable(List<String> sqlList) async {
    try {
      await db!.transaction((txn) async {
        var batch = txn.batch();
        for (String sql in sqlList) {
          batch.execute("CREATE TABLE IF NOT EXISTS $sql");
        }
        await batch.commit();
        AdeptLog.i(sqlList.length, tag: 'Created');
      });
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
      rethrow;
    }
  }

  Future<void> insert({
    String? tableName,
    dynamic model,
    Map<String, dynamic>? map,
    String? sqlQuery,
    List? args,
  }) async {
    try {
      if (model != null && tableName != null) {
        await db!.insert(
          tableName,
          model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        AdeptLog.i('Inserted using model', tag: tableName);
      } else if (map != null && tableName != null) {
        await db!.insert(
          tableName,
          map,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        AdeptLog.i('Inserted using map', tag: tableName);
      } else if (sqlQuery != null) {
        await db!.rawInsert(sqlQuery, args);
        AdeptLog.i('Inserted using raw SQL', tag: _getTableName(sqlQuery));
      } else {
        throw ArgumentError(
          'Either tableName + model, tableName + map, or sqlQuery must be provided',
        );
      }
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
      rethrow;
    }
  }

  Future<void> batchInsert(String tableName, List<dynamic> modelList) async {
    try {
      await db!.transaction((txn) async {
        var batch = txn.batch();
        for (var record in modelList) {
          batch.insert(
            tableName,
            record.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await batch.commit();
      });
      AdeptLog.i('Inserted', tag: tableName);
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
      rethrow;
    }
  }

  Future<void> update({
    String? tableName,
    dynamic model,
    String? where,
    List? whereArgs,
    String? sqlQuery,
    List? args,
  }) async {
    try {
      if (model != null && tableName != null) {
        where == null
            ? throw ArgumentError('where clause required for update')
            : await db!.update(
                tableName,
                model.toMap(),
                where: where,
                whereArgs: whereArgs,
              );
        AdeptLog.i('Updated using model', tag: tableName);
      } else if (sqlQuery != null) {
        await db!.rawUpdate(sqlQuery, args);
        AdeptLog.i('Updated using raw SQL', tag: _getTableName(sqlQuery));
      } else {
        throw ArgumentError(
          'Either tableName + model or sqlQuery must be provided',
        );
      }
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
      rethrow;
    }
  }

  Future<void> updateBatch(
    String tableName,
    List<dynamic> modelList,
    String whereClause,
  ) async {
    try {
      await db!.transaction((txn) async {
        var batch = txn.batch();
        for (var record in modelList) {
          batch.update(
            tableName,
            record.toMap(),
            where: whereClause,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await batch.commit();
      });
      AdeptLog.i('Updated', tag: tableName);
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> select({
    String? tableName,
    String? sqlQuery,
    List<dynamic>? where,
    int? page,
    int? limit,
  }) async {
    try {
      List<Map<String, dynamic>> result;
      String tag;
      String pagination = '';
      if (page != null && limit != null) {
        final offset = page * limit;
        pagination = ' LIMIT $limit OFFSET $offset';
      }
      if (tableName != null) {
        result = await db!.rawQuery('SELECT * FROM $tableName$pagination');
        tag = tableName;
      } else if (sqlQuery != null) {
        result = await db!.rawQuery('$sqlQuery$pagination', where);
        tag = _getTableName(sqlQuery);
      } else {
        throw ArgumentError('Either tableName or sqlQuery must be provided');
      }
      AdeptLog.s(result, tag: tag);
      return result;
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
      return [];
    }
  }

  Future<int> delete({
    String? tableName,
    String? where,
    List? whereArgs,
    String? rawSql,
  }) async {
    try {
      int count = 0;
      String tag = tableName ?? 'UnknownTable';
      if (rawSql != null) {
        tag = _getTableName(rawSql);
        count = await db!.rawDelete(rawSql, whereArgs);
      } else if (tableName != null) {
        count = await db!.delete(tableName, where: where, whereArgs: whereArgs);
      } else {
        throw ArgumentError('Either tableName or rawSql must be provided');
      }
      AdeptLog.s('$count row(s) deleted', tag: tag);
      return count;
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
      rethrow;
    }
  }

  String _getTableName(String sql) {
    sql = sql.trim().toUpperCase();
    final regex = sql.startsWith('SELECT')
        ? RegExp(r'FROM\s+([^\s;]+)', caseSensitive: false)
        : sql.startsWith('INSERT')
        ? RegExp(r'INTO\s+([^\s\(;]+)', caseSensitive: false)
        : sql.startsWith('UPDATE')
        ? RegExp(r'UPDATE\s+([^\s;]+)', caseSensitive: false)
        : sql.startsWith('DELETE')
        ? RegExp(r'FROM\s+([^\s;]+)', caseSensitive: false)
        : null;
    final match = regex?.firstMatch(sql);
    if (match != null && match.groupCount >= 1) return match.group(1)!;
    return 'UnknownTable';
  }
}
