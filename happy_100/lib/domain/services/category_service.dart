import 'package:drift/drift.dart';
import '../context/database.dart';

class CategoryWithActions {
  final Category category;
  final List<CategoryAction> actions;

  CategoryWithActions({required this.category, required this.actions});
}

class CategoryService {
  final AppDatabase _db;

  CategoryService(this._db);

  // Create
  Future<int> createCategory(
    CategoriesCompanion category,
    List<int> actionIds,
  ) async {
    return await _db.transaction(() async {
      // Create the category first
      final categoryId = await _db.into(_db.categories).insert(category);

      // Create category actions for each action ID
      for (final actionId in actionIds) {
        await _db
            .into(_db.categoryActions)
            .insert(
              CategoryActionsCompanion(
                categoryId: Value(categoryId),
                actionId: Value(actionId),
              ),
            );
      }

      return categoryId;
    });
  }

  // Read
  Future<List<CategoryWithActions>> getAllCategories() async {
    final categories = await _db.select(_db.categories).get();
    final result = <CategoryWithActions>[];

    for (final category in categories) {
      final actions = await _db.select(_db.categoryActions)
        ..where((tbl) => tbl.categoryId.equals(category.id));

      result.add(
        CategoryWithActions(category: category, actions: await actions.get()),
      );
    }

    return result;
  }

  Future<CategoryWithActions?> getCategoryById(int id) async {
    final category =
        await (_db.select(_db.categories)
          ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

    if (category == null) return null;

    final actions =
        await (_db.select(_db.categoryActions)
          ..where((tbl) => tbl.categoryId.equals(id))).get();

    return CategoryWithActions(category: category, actions: actions);
  }

  // Update
  Future<bool> updateCategory(CategoriesCompanion category) async {
    return await _db.update(_db.categories).replace(category);
  }

  // Delete
  Future<int> deleteCategory(int id) async {
    return await (_db.delete(_db.categories)
      ..where((tbl) => tbl.id.equals(id))).go();
  }
}
