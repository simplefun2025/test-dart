import 'package:drift/drift.dart';

import '../../core/services/database.dart';

class CategoryActionRepository {
  final AppDatabase _db;

  CategoryActionRepository(this._db);

  Future<void> createCategoryActions({
    required int categoryId,
    required List<int> actionIds,
  }) async {
    await _db.managers.categoryActions.bulkCreate(
      (obj) => actionIds.map(
        (actionId) => obj(categoryId: categoryId, actionId: actionId),
      ),
    );
  }

  Future<void> deleteCategoryActions({
    required int categoryId,
    required List<int> actionIds,
  }) async {
    await _db.managers.categoryActions
        .filter((filter) => filter.actionId.isIn(actionIds))
        .update((obj) => obj(deletedAt: Value(DateTime.now())));
  }
}
