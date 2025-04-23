import '../entities/record.dart';

abstract class RecordRepository {
  /// 기록 생성
  Future<Records> createRecord({
    required int actionId,
    int? memoId,
    required DateTime date,
  });

  /// 기록 조회
  Future<Records> getRecord(int id);

  /// 기록 목록 조회
  Future<List<Records>> getRecords({DateTime? startDate, DateTime? endDate});

  /// 기록 수정
  Future<Records> updateRecord({
    required int id,
    required int actionId,
    int? memoId,
    required DateTime date,
  });

  /// 기록 삭제
  Future<void> deleteRecord(int id);
}
