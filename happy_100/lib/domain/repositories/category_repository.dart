import '../entities/category.dart';
import '../entities/action.dart';

abstract class CategoryRepository {
  /// 카테고리 생성
  Future<Categories> createCategory({
    required String name,
    String? description,
    required List<Actions> actions,
  });

  /// 카테고리 수정
  Future<Categories> updateCategory({
    required int id,
    required String name,
    String? description,
    required List<Actions> actions,
  });

  /// 카테고리 삭제
  Future<void> deleteCategory(int id);

  /// 카테고리 예약
  Future<void> reserveCategory({
    required int categoryId,
    required DateTime date,
  });

  /// 카테고리 목록 조회
  Future<List<Categories>> getCategories();

  /// 카테고리 상세 조회
  Future<Categories> getCategory(int id);
}
