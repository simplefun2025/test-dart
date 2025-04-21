import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import '../entities/index.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Actions, Categories, CategoryActions, Records])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    //final dbFile = File('./db/db.sqlite');
    return NativeDatabase.createInBackground(File('./db/db.sqlite'));
  }
}
