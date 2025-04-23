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

  group('CategoryActions 테이블 테스트', () {
    test('카테고리 액션 생성 및 조회', () async {
      final now = DateTime.now();
      final categoryAction = CategoryAction(
        id: 0,
        categoryId: 1,
        actionId: 1,
        createdAt: now,
        updatedAt: now,
      );

      final companion = CategoryActionsCompanion.insert(
        categoryId: categoryAction.categoryId,
        actionId: categoryAction.actionId,
        createdAt: categoryAction.createdAt,
        updatedAt: categoryAction.updatedAt,
      );

      final id = await db.into(db.categoryActions).insert(companion);
      final result = await db.select(db.categoryActions).getSingle();

      expect(result.id, equals(id));
      expect(result.categoryId, equals(categoryAction.categoryId));
      expect(result.actionId, equals(categoryAction.actionId));
    });
  });
}
