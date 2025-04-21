import 'package:drift/drift.dart';
import 'actions.dart';

class Records extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get actionId => integer().references(Actions, #id)();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
