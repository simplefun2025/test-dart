import 'package:test/test.dart';
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

  group('Memos 테이블 테스트', () {
    test('메모 생성 및 조회', () async {
      final now = DateTime.now();
      final memo = Memo(
        id: 0,
        content: '테스트 메모',
        createdAt: now,
        updatedAt: now,
      );

      final companion = MemosCompanion.insert(
        content: memo.content,
        createdAt: memo.createdAt,
        updatedAt: memo.updatedAt,
      );

      final id = await db.into(db.memos).insert(companion);
      final result = await db.select(db.memos).getSingle();

      expect(result.id, equals(id));
      expect(result.content, equals(memo.content));
    });
  });
}
