import '../entities/record.dart';
import '../repositories/record_repository.dart';

class RecordService {
  final RecordRepository _repository;

  RecordService(this._repository);

  /// 기록 생성
  Future<Records> createRecord({
    required int actionId,
    int? memoId,
    required DateTime date,
  }) async {
    return await _repository.createRecord(
      actionId: actionId,
      memoId: memoId,
      date: date,
    );
  }

  /// 기록 조회
  Future<Records> getRecord(int id) async {
    return await _repository.getRecord(id);
  }

  /// 기록 목록 조회
  Future<List<Records>> getRecords({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _repository.getRecords(startDate: startDate, endDate: endDate);
  }

  /// 기록 수정
  Future<Records> updateRecord({
    required int id,
    required int actionId,
    int? memoId,
    required DateTime date,
  }) async {
    return await _repository.updateRecord(
      id: id,
      actionId: actionId,
      memoId: memoId,
      date: date,
    );
  }

  /// 기록 삭제
  Future<void> deleteRecord(int id) async {
    await _repository.deleteRecord(id);
  }
}
