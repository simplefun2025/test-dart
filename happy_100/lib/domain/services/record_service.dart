import '../context/database.dart';

class RecordService {
  final AppDatabase _db;

  RecordService(this._db);

  // Create
  Future<int> createRecord(RecordsCompanion record) async {
    return await _db.into(_db.records).insert(record);
  }

  // Read
  Future<List<Record>> getAllRecords() async {
    return await _db.select(_db.records).get();
  }

  Future<Record?> getRecordById(int id) async {
    return await (_db.select(_db.records)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<Record>> getRecordsByActionId(int actionId) async {
    return await (_db.select(_db.records)
      ..where((tbl) => tbl.actionId.equals(actionId))).get();
  }

  // Update
  Future<bool> updateRecord(RecordsCompanion record) async {
    return await _db.update(_db.records).replace(record);
  }

  // Delete
  Future<int> deleteRecord(int id) async {
    return await (_db.delete(_db.records)
      ..where((tbl) => tbl.id.equals(id))).go();
  }
}
