import 'package:drift/drift.dart';
import '../../core/services/database.dart';

/// 기록 저장소
class RecordRepository {
  final AppDatabase _db;

  RecordRepository(this._db);

  /// 기록 생성
  Future<int> createRecord({
    required int actionId,
    int? memoId,
    required DateTime date,
  }) async {
    final recordId = await _db.managers.records.create(
      (obj) => obj(actionId: actionId, memoId: Value(memoId), date: date),
    );

    return recordId;
  }

  /// 기록 조회
  Future<Record> getRecord(int id) async {
    final record =
        await _db.managers.records.filter((f) => f.id.equals(id)).getSingle();

    return record;
  }

  /// 기록 목록 조회
  Future<List<Record>> getRecords({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    var query = _db.managers.records.filter(
      (f) => f.date.isBetween(startDate, endDate),
    );

    return await query.get();
  }

  /// 기록 수정
  Future<Record> updateRecord({
    required int id,
    required int actionId,
    int? memoId,
    required DateTime date,
  }) async {
    await _db.managers.records
        .filter((f) => f.id.equals(id))
        .update(
          (obj) => obj(
            actionId: Value(actionId),
            memoId: Value(memoId),
            date: Value(date),
          ),
        );

    final record = await getRecord(id);
    return record;
  }

  /// 기록 삭제
  Future<void> deleteRecord(int id) async {
    await _db.managers.records.filter((f) => f.id.equals(id)).delete();
  }

  /// 기록 전체 삭제
  Future<void> deleteAllRecords() async {
    await _db.managers.records.delete();
  }
}
