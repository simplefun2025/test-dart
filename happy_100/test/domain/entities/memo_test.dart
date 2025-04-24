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

  group('Memos 테이블 테스트', () {
    test('기본 메모 생성 및 조회', () async {
      final companion = MemosCompanion.insert(content: '오늘은 정말 좋은 날이었다.');

      final id = await db.into(db.memos).insert(companion);
      final result = await db.select(db.memos).getSingle();

      expect(result.id, equals(id));
      expect(result.content, equals('오늘은 정말 좋은 날이었다.'));
      expect(result.createdAt, isNotNull);
      expect(result.deletedAt, isNull);
    });

    test('삭제된 메모 생성', () async {
      final now = DateTime.now();
      final companion = MemosCompanion.insert(
        content: '삭제된 메모',
        deletedAt: Value(now),
      );

      final id = await db.into(db.memos).insert(companion);
      final result = await db.select(db.memos).getSingle();

      expect(result.id, equals(id));
      expect(result.content, equals('삭제된 메모'));
      expect(result.createdAt, isNotNull);
      expect(result.deletedAt, equals(now));
    });
  });
}
