import '/core/services/database.dart';
import '../repositories/record_repository.dart';

class RecordService {
  final RecordRepository _repository;
  final AppDatabase _db;

  RecordService({required AppDatabase db, required RecordRepository repository})
    : _db = db,
      _repository = repository;

  /// 기록 생성
  Future<Record> createRecord({
    required int actionId,
    int? memoId,
    required DateTime date,
  }) async {
    return await _db.transaction(() async {
      final recordId = await _repository.createRecord(
        actionId: actionId,
        memoId: memoId,
        date: date,
      );

      return await getRecord(recordId);
    });
  }

  /// 기록 조회
  Future<Record> getRecord(int id) async {
    return await _repository.getRecord(id);
  }

  /// 기록 목록 조회
  Future<List<Record>> getRecords({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return await _repository.getRecords(startDate: startDate, endDate: endDate);
  }

  /// 기록 수정
  Future<Record> updateRecord({
    required int id,
    required int actionId,
    int? memoId,
    required DateTime date,
  }) async {
    return await _db.transaction(() async {
      return await _repository.updateRecord(
        id: id,
        actionId: actionId,
        memoId: memoId,
        date: date,
      );
    });
  }

  /// 기록 삭제
  Future<void> deleteRecord(int id) async {
    await _db.transaction(() async {
      await _repository.deleteRecord(id);
    });
  }

  Future<void> deleteAllRecords() async {
    await _db.transaction(() async {
      await _repository.deleteAllRecords();
    });
  }
}
