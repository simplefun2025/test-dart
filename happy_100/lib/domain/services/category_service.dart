import '/core/services/database.dart';
import '../repositories/category_action_repository.dart';
import '../repositories/category_repository.dart';

class CategoryService {
  final AppDatabase _db;
  final CategoryRepository _categoryRepository;
  final CategoryActionRepository _categoryActionRepository;

  CategoryService({
    required AppDatabase db,
    required CategoryRepository categoryRepository,
    required CategoryActionRepository categoryActionRepository,
  }) : _db = db,
       _categoryRepository = categoryRepository,
       _categoryActionRepository = categoryActionRepository;

  /// 카테고리 생성
  Future<int> createCategory({
    required String name,
    String? description,
    required List<Action> actions,
  }) async {
    return await _db.transaction(() async {
      final categoryId = await _categoryRepository.createCategory(
        name: name,
        description: description,
      );

      await _categoryActionRepository.createCategoryActions(
        categoryId: categoryId,
        actionIds: actions.map((e) => e.id).toList(),
      );

      return categoryId;
    });
  }

  /// 카테고리 수정
  Future<Category> updateCategory({
    required int id,
    required String name,
    String? description,
    required List<Action> actions,
  }) async {
    return await _db.transaction(() async {
      final category = await _categoryRepository.updateCategory(
        id: id,
        name: name,
        description: description,
      );

      await _categoryActionRepository.deleteCategoryActions(
        categoryId: id,
        actionIds: actions.map((e) => e.id).toList(),
      );

      await _categoryActionRepository.createCategoryActions(
        categoryId: id,
        actionIds: actions.map((e) => e.id).toList(),
      );

      return category;
    });
  }

  /// 카테고리 삭제
  Future<void> deleteCategory(int id) async {
    await _db.transaction(() async {
      await _categoryRepository.deleteCategory(id);
    });
  }

  /// 카테고리 전체 삭제
  Future<void> deleteAllCategories() async {
    await _db.transaction(() async {
      await _categoryRepository.deleteAllCategories();
    });
  }

  /// 카테고리 목록 조회
  Future<List<Category>> getCategories() async {
    return await _categoryRepository.getCategories();
  }

  /// 카테고리 상세 조회
  Future<Category> getCategory(int id) async {
    return await _categoryRepository.getCategory(id);
  }
}
