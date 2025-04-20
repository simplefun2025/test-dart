import 'package:drift/drift.dart';
import 'categories.dart';
import 'actions.dart';

class CategoryActions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  IntColumn get actionId => integer().references(Actions, #id)();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
