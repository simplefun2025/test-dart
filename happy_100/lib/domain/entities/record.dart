import 'package:drift/drift.dart';

class Records extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get actionId => integer()();
  IntColumn get memoId => integer().nullable()();
  DateTimeColumn get date => dateTime()();
}
