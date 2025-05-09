import 'package:test/test.dart';
import 'package:drift/native.dart';
import 'package:happy_100/core/services/database.dart';
import 'package:happy_100/domain/repositories/category_repository.dart';

void main() {
  late AppDatabase db;
  late CategoryRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = CategoryRepository(db);
  });

  tearDown(() {
    db.close();
  });

  group('CategoryRepository 테스트', () {
    test('카테고리 생성', () async {
      final categoryId = await repository.createCategory(
        name: '운동',
        description: '건강을 위한 운동',
      );

      final category = await repository.getCategory(categoryId);

      expect(category.name, equals('운동'));
      expect(category.description, equals('건강을 위한 운동'));
    });

    test('카테고리 수정', () async {
      final categoryId = await repository.createCategory(
        name: '운동',
        description: '건강을 위한 운동',
      );

      final updatedCategory = await repository.updateCategory(
        id: categoryId,
        name: '독서',
        description: '지식을 위한 독서',
      );

      expect(updatedCategory.name, equals('독서'));
      expect(updatedCategory.description, equals('지식을 위한 독서'));
    });

    test('카테고리 삭제', () async {
      final categoryId = await repository.createCategory(
        name: '운동',
        description: '건강을 위한 운동',
      );

      await repository.deleteCategory(categoryId);

      expect(
        () => repository.getCategory(categoryId),
        throwsA(isA<StateError>()),
      );
    });

    test('카테고리 목록 조회', () async {
      await repository.createCategory(name: '운동', description: '건강을 위한 운동');

      await repository.createCategory(name: '독서', description: '지식을 위한 독서');

      final categories = await repository.getCategories();

      expect(categories.length, equals(2));
      expect(categories[0].name, equals('운동'));
      expect(categories[1].name, equals('독서'));
    });

    test('카테고리 상세 조회', () async {
      final categoryId = await repository.createCategory(
        name: '운동',
        description: '건강을 위한 운동',
      );

      final foundCategory = await repository.getCategory(categoryId);

      expect(foundCategory.id, equals(categoryId));
      expect(foundCategory.name, equals('운동'));
      expect(foundCategory.description, equals('건강을 위한 운동'));
    });
  });
}
