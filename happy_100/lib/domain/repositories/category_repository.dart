import 'package:drift/drift.dart';
import '../../core/services/database.dart';

/// 카테고리 저장소
class CategoryRepository {
  final AppDatabase _db;

  CategoryRepository(this._db);

  /// 카테고리 생성
  Future<int> createCategory({
    required String name,
    String? description,
  }) async {
    final categoryId = await _db.managers.categories.create(
      (obj) => obj(name: name, description: Value(description)),
    );

    return categoryId;
  }

  /// 카테고리 수정
  Future<Category> updateCategory({
    required int id,
    required String name,
    String? description,
  }) async {
    await _db.managers.categories
        .filter((f) => f.id.equals(id))
        .update(
          (obj) => obj(name: Value(name), description: Value(description)),
        );

    final category = await getCategory(id);
    return category;
  }

  /// 카테고리 삭제
  Future<void> deleteCategory(int id) async {
    await _db.managers.categories
        .filter((f) => f.id.equals(id))
        .update((obj) => obj(deletedAt: Value(DateTime.now())));
  }

  /// 카테고리 목록 조회
  Future<List<Category>> getCategories() async {
    return await _db.managers.categories
        .filter((f) => f.deletedAt.isNull())
        .get();
  }

  /// 카테고리 상세 조회
  Future<Category> getCategory(int id) async {
    final category =
        await _db.managers.categories
            .filter((f) => f.id.equals(id) & f.deletedAt.isNull())
            .getSingle();

    if (category == null) {
      throw Exception('Category not found');
    }

    return category;
  }
}
