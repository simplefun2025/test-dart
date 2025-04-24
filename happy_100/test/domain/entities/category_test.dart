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

  group('Categories 테이블 테스트', () {
    test('기본 카테고리 생성 및 조회', () async {
      final companion = CategoriesCompanion.insert(
        name: '운동',
        description: Value('건강을 위한 운동'),
      );

      final id = await db.into(db.categories).insert(companion);
      final result = await db.select(db.categories).getSingle();

      expect(result.id, equals(id));
      expect(result.name, equals('운동'));
      expect(result.description, equals('건강을 위한 운동'));
      expect(result.createdAt, isNotNull);
      expect(result.deletedAt, isNull);
    });

    test('설명이 없는 카테고리 생성', () async {
      final companion = CategoriesCompanion.insert(name: '독서');

      final id = await db.into(db.categories).insert(companion);
      final result = await db.select(db.categories).getSingle();

      expect(result.id, equals(id));
      expect(result.name, equals('독서'));
      expect(result.description, isNull);
      expect(result.createdAt, isNotNull);
      expect(result.deletedAt, isNull);
    });

    test('삭제된 카테고리 생성', () async {
      final now = DateTime.now();
      final companion = CategoriesCompanion.insert(
        name: '삭제된 카테고리',
        deletedAt: Value(now),
      );

      final id = await db.into(db.categories).insert(companion);
      final result = await db.select(db.categories).getSingle();

      expect(result.id, equals(id));
      expect(result.name, equals('삭제된 카테고리'));
      expect(result.description, isNull);
      expect(result.createdAt, isNotNull);
      expect(result.deletedAt, equals(now));
    });
  });
}
