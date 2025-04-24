import 'package:drift/drift.dart';
import '../../core/services/database.dart';

/// 기록 저장소
class RecordRepository {
  final AppDatabase _db;

  RecordRepository(this._db);

  /// 기록 생성
  Future<Record> createRecord({
    required int actionId,
    int? memoId,
    required DateTime date,
  }) async {
    final recordId = await _db
        .into(_db.records)
        .insert(
          RecordsCompanion.insert(
            actionId: actionId,
            memoId: Value(memoId),
            date: DateTime.now(),
          ),
        );

    final record = await getRecord(recordId);
    return record;
  }

  /// 기록 조회
  Future<Record> getRecord(int id) async {
    final record =
        await (_db.select(_db.records)
          ..where((t) => t.id.equals(id))).getSingleOrNull();

    if (record == null) {
      throw Exception('Record not found');
    }

    return record;
  }

  /// 기록 목록 조회
  Future<List<Record>> getRecords({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var query = _db.select(_db.records);

    if (startDate != null) {
      query.where((t) => t.date.isBiggerOrEqualValue(startDate));
    }

    if (endDate != null) {
      query.where((t) => t.date.isSmallerOrEqualValue(endDate));
    }

    return await query.get();
  }

  /// 기록 수정
  Future<Record> updateRecord({
    required int id,
    required int actionId,
    int? memoId,
    required DateTime date,
  }) async {
    await (_db.update(_db.records)..where((t) => t.id.equals(id))).write(
      RecordsCompanion(actionId: Value(actionId), memoId: Value(memoId)),
    );

    final record = await getRecord(id);
    return record;
  }

  /// 기록 삭제
  Future<void> deleteRecord(int id) async {
    await (_db.delete(_db.records)..where((t) => t.id.equals(id))).go();
  }
}
