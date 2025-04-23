import 'package:test/test.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:happy_100/core/services/database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() {
    db.close();
  });

  group('Records 테이블 테스트', () {
    test('레코드 생성 및 조회', () async {
      final now = DateTime.now();
      final record = Record(id: 0, actionId: 1, memoId: null, date: now);

      final companion = RecordsCompanion(
        actionId: Value(record.actionId),
        date: Value(record.date),
      );

      final id = await db.into(db.records).insert(companion);
      final result = await db.select(db.records).getSingle();

      expect(result.id, equals(id));
      expect(result.actionId, equals(record.actionId));
      expect(result.memoId, isNull);
    });

    test('메모가 있는 레코드 생성', () async {
      final now = DateTime.now();
      final record = Record(id: 0, actionId: 1, memoId: 1, date: now);

      final companion = RecordsCompanion(
        actionId: Value(record.actionId),
        memoId: Value(record.memoId),
        date: Value(record.date),
      );

      final id = await db.into(db.records).insert(companion);
      final result = await db.select(db.records).getSingle();

      expect(result.id, equals(id));
      expect(result.actionId, equals(record.actionId));
      expect(result.memoId, equals(record.memoId));
    });
  });
}
