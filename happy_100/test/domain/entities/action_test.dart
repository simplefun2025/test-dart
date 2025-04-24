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

  group('Actions 테이블 테스트', () {
    test('기본 액션 생성 및 조회', () async {
      final companion = ActionsCompanion.insert(
        name: '운동하기',
        description: Value('매일 30분 운동'),
      );

      final id = await db.into(db.actions).insert(companion);
      final result = await db.select(db.actions).getSingle();

      expect(result.id, equals(id));
      expect(result.name, equals('운동하기'));
      expect(result.description, equals('매일 30분 운동'));
      expect(result.categoryId, isNull);
      expect(result.createdAt, isNotNull);
      expect(result.deletedAt, isNull);
    });

    test('카테고리가 있는 액션 생성', () async {
      final companion = ActionsCompanion.insert(
        name: '독서하기',
        description: Value('매일 1시간 독서'),
        categoryId: Value(1),
      );

      final id = await db.into(db.actions).insert(companion);
      final result = await db.select(db.actions).getSingle();

      expect(result.id, equals(id));
      expect(result.name, equals('독서하기'));
      expect(result.description, equals('매일 1시간 독서'));
      expect(result.categoryId, equals(1));
      expect(result.createdAt, isNotNull);
      expect(result.deletedAt, isNull);
    });

    test('삭제된 액션 생성', () async {
      final now = DateTime.now();
      final companion = ActionsCompanion.insert(
        name: '삭제된 액션',
        deletedAt: Value(now),
      );

      final id = await db.into(db.actions).insert(companion);
      final result = await db.select(db.actions).getSingle();

      expect(result.id, equals(id));
      expect(result.name, equals('삭제된 액션'));
      expect(result.description, isNull);
      expect(result.categoryId, isNull);
      expect(result.createdAt, isNotNull);
      expect(result.deletedAt, equals(now));
    });
  });
}
