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

  group('CategoryActions 테이블 테스트', () {
    test('기본 카테고리-액션 관계 생성 및 조회', () async {
      final companion = CategoryActionsCompanion.insert(
        categoryId: 1,
        actionId: 1,
      );

      final id = await db.into(db.categoryActions).insert(companion);
      final result = await db.select(db.categoryActions).getSingle();

      expect(result.id, equals(id));
      expect(result.categoryId, equals(1));
      expect(result.actionId, equals(1));
      expect(result.createdAt, isNotNull);
      expect(result.deletedAt, isNull);
    });

    test('삭제된 카테고리-액션 관계 생성', () async {
      final now = DateTime.now();
      final companion = CategoryActionsCompanion.insert(
        categoryId: 1,
        actionId: 1,
        deletedAt: Value(now),
      );

      final id = await db.into(db.categoryActions).insert(companion);
      final result = await db.select(db.categoryActions).getSingle();

      expect(result.id, equals(id));
      expect(result.categoryId, equals(1));
      expect(result.actionId, equals(1));
      expect(result.createdAt, isNotNull);
      expect(result.deletedAt, equals(now));
    });
  });
}
