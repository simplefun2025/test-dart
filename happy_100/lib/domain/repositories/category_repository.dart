import 'package:drift/drift.dart';
import '../../core/services/database.dart';

/// 카테고리 저장소
class CategoryRepository {
  final AppDatabase _db;

  CategoryRepository(this._db);

  /// 카테고리 생성
  Future<Category> createCategory({
    required String name,
    String? description,
    required List<Action> actions,
  }) async {
    final categoryId = await _db
        .into(_db.categories)
        .insert(
          CategoriesCompanion.insert(
            name: name,
            description: Value(description),
          ),
        );

    final category = await getCategory(categoryId);
    return category;
  }

  /// 카테고리 수정
  Future<Category> updateCategory({
    required int id,
    required String name,
    String? description,
    required List<Action> actions,
  }) async {
    await (_db.update(_db.categories)..where((t) => t.id.equals(id))).write(
      CategoriesCompanion(name: Value(name), description: Value(description)),
    );

    final category = await getCategory(id);
    return category;
  }

  /// 카테고리 삭제
  Future<void> deleteCategory(int id) async {
    await (_db.delete(_db.categories)..where((t) => t.id.equals(id))).go();
  }

  /// 카테고리 예약
  Future<void> reserveCategory({
    required int categoryId,
    required DateTime date,
  }) async {
    // TODO: 예약 로직 구현
    // 현재는 단순히 예약 기능만 선언
  }

  /// 카테고리 목록 조회
  Future<List<Category>> getCategories() async {
    return await _db.select(_db.categories).get();
  }

  /// 카테고리 상세 조회
  Future<Category> getCategory(int id) async {
    final category =
        await (_db.select(_db.categories)
          ..where((t) => t.id.equals(id))).getSingleOrNull();

    if (category == null) {
      throw Exception('Category not found');
    }

    return category;
  }
}
