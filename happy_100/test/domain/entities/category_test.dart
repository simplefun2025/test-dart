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

  group('Categories 테이블 테스트', () {
    test('카테고리 생성 및 조회', () async {
      final now = DateTime.now();
      final category = Category(
        id: 0,
        name: '테스트 카테고리',
        description: '테스트 설명',
        createdAt: now,
        updatedAt: now,
      );

      final companion = CategoriesCompanion.insert(
        name: category.name,
        description: Value(category.description),
        createdAt: category.createdAt,
        updatedAt: category.updatedAt,
      );

      final id = await db.into(db.categories).insert(companion);
      final result = await db.select(db.categories).getSingle();

      expect(result.id, equals(id));
      expect(result.name, equals(category.name));
      expect(result.description, equals(category.description));
    });

    test('설명이 없는 카테고리 생성', () async {
      final now = DateTime.now();
      final category = Category(
        id: 0,
        name: '테스트 카테고리',
        description: null,
        createdAt: now,
        updatedAt: now,
      );

      final companion = CategoriesCompanion.insert(
        name: category.name,
        createdAt: category.createdAt,
        updatedAt: category.updatedAt,
      );

      final id = await db.into(db.categories).insert(companion);
      final result = await db.select(db.categories).getSingle();

      expect(result.id, equals(id));
      expect(result.name, equals(category.name));
      expect(result.description, isNull);
    });
  });
}
