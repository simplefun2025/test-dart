import 'package:drift/drift.dart';

class CategoryActions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer()();
  IntColumn get actionId => integer()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
