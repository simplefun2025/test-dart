import '../entities/category.dart';
import '../entities/action.dart';
import '../repositories/category_repository.dart';

class CategoryService {
  final CategoryRepository _repository;

  CategoryService(this._repository);

  /// 카테고리 생성
  Future<Categories> createCategory({
    required String name,
    String? description,
    required List<Actions> actions,
  }) async {
    return await _repository.createCategory(
      name: name,
      description: description,
      actions: actions,
    );
  }

  /// 카테고리 수정
  Future<Categories> updateCategory({
    required int id,
    required String name,
    String? description,
    required List<Actions> actions,
  }) async {
    return await _repository.updateCategory(
      id: id,
      name: name,
      description: description,
      actions: actions,
    );
  }

  /// 카테고리 삭제
  Future<void> deleteCategory(int id) async {
    await _repository.deleteCategory(id);
  }

  /// 카테고리 예약
  Future<void> reserveCategory({
    required int categoryId,
    required DateTime date,
  }) async {
    await _repository.reserveCategory(categoryId: categoryId, date: date);
  }

  /// 카테고리 목록 조회
  Future<List<Categories>> getCategories() async {
    return await _repository.getCategories();
  }

  /// 카테고리 상세 조회
  Future<Categories> getCategory(int id) async {
    return await _repository.getCategory(id);
  }
}
