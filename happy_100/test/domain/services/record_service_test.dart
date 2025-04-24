import 'package:test/test.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:happy_100/core/services/database.dart';
import 'package:happy_100/domain/repositories/record_repository.dart';
import 'package:happy_100/domain/services/record_service.dart';

void main() {
  late AppDatabase db;
  late RecordRepository repository;
  late RecordService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = RecordRepository(db);
    service = RecordService(repository);
  });

  tearDown(() {
    db.close();
  });

  group('RecordService 테스트', () {
    test('기록 생성', () async {
      final now = DateTime.now();
      final record = await service.createRecord(actionId: 1, date: now);

      expect(record.actionId, equals(1));
      expect(record.memoId, isNull);
      expect(record.date, isNotNull);
    });

    test('메모가 있는 기록 생성', () async {
      final now = DateTime.now();
      final record = await service.createRecord(
        actionId: 1,
        memoId: 1,
        date: now,
      );

      expect(record.actionId, equals(1));
      expect(record.memoId, equals(1));
      expect(record.date, isNotNull);
    });

    test('기록 수정', () async {
      final now = DateTime.now();
      final record = await service.createRecord(actionId: 1, date: now);

      final updatedRecord = await service.updateRecord(
        id: record.id,
        actionId: 2,
        memoId: 1,
        date: now,
      );

      expect(updatedRecord.actionId, equals(2));
      expect(updatedRecord.memoId, equals(1));
    });

    test('기록 삭제', () async {
      final now = DateTime.now();
      final record = await service.createRecord(actionId: 1, date: now);

      await service.deleteRecord(record.id);

      expect(() => service.getRecord(record.id), throwsException);
    });

    test('기록 목록 조회 - 날짜 범위 지정', () async {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));
      final tomorrow = now.add(const Duration(days: 1));

      await service.createRecord(actionId: 1, date: yesterday);

      await service.createRecord(actionId: 2, date: now);

      await service.createRecord(actionId: 3, date: tomorrow);

      final records = await service.getRecords(startDate: now, endDate: now);

      expect(records.length, equals(1));
      expect(records[0].actionId, equals(2));
    });

    test('기록 상세 조회', () async {
      final now = DateTime.now();
      final record = await service.createRecord(
        actionId: 1,
        memoId: 1,
        date: now,
      );

      final foundRecord = await service.getRecord(record.id);

      expect(foundRecord.id, equals(record.id));
      expect(foundRecord.actionId, equals(1));
      expect(foundRecord.memoId, equals(1));
    });
  });
}
