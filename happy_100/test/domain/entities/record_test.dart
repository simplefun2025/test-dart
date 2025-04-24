import 'package:test/test.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
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
    test('기본 레코드 생성 및 조회', () async {
      final now = DateTime.now();
      final companion = RecordsCompanion.insert(actionId: 1, date: now);

      final id = await db.into(db.records).insert(companion);
      final result = await db.select(db.records).getSingle();

      expect(result.id, equals(id));
      expect(result.actionId, equals(1));
      expect(result.memoId, isNull);
      expect(result.date, equals(now));
      expect(result.createdAt, isNotNull);
    });

    test('메모가 있는 레코드 생성', () async {
      final now = DateTime.now();
      final companion = RecordsCompanion.insert(
        actionId: 1,
        memoId: Value(1),
        date: now,
      );

      final id = await db.into(db.records).insert(companion);
      final result = await db.select(db.records).getSingle();

      expect(result.id, equals(id));
      expect(result.actionId, equals(1));
      expect(result.memoId, equals(1));
      expect(result.date, equals(now));
      expect(result.createdAt, isNotNull);
    });
  });
}
