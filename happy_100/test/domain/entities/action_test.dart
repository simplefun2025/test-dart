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

  group('Actions 테이블 테스트', () {
    test('액션 생성 및 조회', () async {
      final now = DateTime.now();
      final action = Action(
        id: 0,
        name: '테스트 액션',
        description: '테스트 설명',
        categoryId: null,
        createdAt: now,
        updatedAt: now,
      );

      final companion = ActionsCompanion(
        name: Value(action.name),
        description: Value(action.description),
        createdAt: Value(action.createdAt),
        updatedAt: Value(action.updatedAt),
      );

      final id = await db.into(db.actions).insert(companion);
      final result = await db.select(db.actions).getSingle();

      expect(result.id, equals(id));
      expect(result.name, equals(action.name));
      expect(result.description, equals(action.description));
      expect(result.categoryId, isNull);
    });

    test('카테고리가 있는 액션 생성', () async {
      final now = DateTime.now();
      final action = Action(
        id: 0,
        name: '테스트 액션',
        description: '테스트 설명',
        categoryId: 1,
        createdAt: now,
        updatedAt: now,
      );

      final companion = ActionsCompanion(
        name: Value(action.name),
        description: Value(action.description),
        categoryId: Value(action.categoryId),
        createdAt: Value(action.createdAt),
        updatedAt: Value(action.updatedAt),
      );

      final id = await db.into(db.actions).insert(companion);
      final result = await db.select(db.actions).getSingle();

      expect(result.id, equals(id));
      expect(result.name, equals(action.name));
      expect(result.description, equals(action.description));
      expect(result.categoryId, equals(action.categoryId));
    });
  });
}
