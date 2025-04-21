import 'package:drift/drift.dart';

class Actions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
  TextColumn get title => text()();
  TextColumn get desc => text()();
  TextColumn get imageUrl => text()();
  IntColumn get type => integer()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
