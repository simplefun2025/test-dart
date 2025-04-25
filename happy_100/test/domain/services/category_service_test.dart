import 'package:test/test.dart';
import 'package:drift/native.dart';
import 'package:happy_100/core/services/database.dart';
import 'package:happy_100/domain/repositories/category_repository.dart';
import 'package:happy_100/domain/repositories/category_action_repository.dart';
import 'package:happy_100/domain/services/category_service.dart';

void main() {
  late AppDatabase db;
  late CategoryRepository categoryRepository;
  late CategoryActionRepository categoryActionRepository;
  late CategoryService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    categoryRepository = CategoryRepository(db);
    categoryActionRepository = CategoryActionRepository(db);
    service = CategoryService(db, categoryRepository, categoryActionRepository);
  });

  tearDown(() {
    db.close();
  });

  group('CategoryService 테스트', () {
    test('카테고리 생성', () async {
      final categoryId = await service.createCategory(
        name: '운동',
        description: '건강을 위한 운동',
        actions: [],
      );

      final category = await service.getCategory(categoryId);
      expect(category.name, equals('운동'));
      expect(category.description, equals('건강을 위한 운동'));
    });

    test('카테고리 수정', () async {
      final categoryId = await service.createCategory(
        name: '운동',
        description: '건강을 위한 운동',
        actions: [],
      );

      final updatedCategory = await service.updateCategory(
        id: categoryId,
        name: '독서',
        description: '지식을 위한 독서',
        actions: [],
      );

      expect(updatedCategory.name, equals('독서'));
      expect(updatedCategory.description, equals('지식을 위한 독서'));
    });

    test('카테고리 삭제', () async {
      final categoryId = await service.createCategory(
        name: '운동',
        description: '건강을 위한 운동',
        actions: [],
      );

      await service.deleteCategory(categoryId);

      expect(() => service.getCategory(categoryId), throwsException);
    });

    test('카테고리 목록 조회', () async {
      await service.createCategory(
        name: '운동',
        description: '건강을 위한 운동',
        actions: [],
      );

      await service.createCategory(
        name: '독서',
        description: '지식을 위한 독서',
        actions: [],
      );

      final categories = await service.getCategories();

      expect(categories.length, equals(2));
      expect(categories[0].name, equals('운동'));
      expect(categories[1].name, equals('독서'));
    });

    test('카테고리 상세 조회', () async {
      final categoryId = await service.createCategory(
        name: '운동',
        description: '건강을 위한 운동',
        actions: [],
      );

      final foundCategory = await service.getCategory(categoryId);

      expect(foundCategory.id, equals(categoryId));
      expect(foundCategory.name, equals('운동'));
      expect(foundCategory.description, equals('건강을 위한 운동'));
    });
  });
}
