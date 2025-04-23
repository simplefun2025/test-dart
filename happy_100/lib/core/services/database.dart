import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:happy_100/domain/entities/record.dart';
import 'package:happy_100/domain/entities/action.dart';
import 'package:happy_100/domain/entities/memo.dart';
import 'package:happy_100/domain/entities/category.dart';
import 'package:happy_100/domain/entities/category_action.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Records, Actions, Memos, Categories, CategoryActions])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = 'C:/Users/user/Desktop/happy_100/happy_100/';
    final file = File(p.join(dbFolder, 'happy_100.db'));
    return NativeDatabase.createInBackground(file);
  });
}
