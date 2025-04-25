import 'package:drift/drift.dart';

import '../../core/services/database.dart';

class ActionRepository {
  final AppDatabase _db;

  ActionRepository(this._db);

  Future<Action> createAction({
    required String name,
    String? description,
    required int categoryId,
  }) async {
    final actionId = await _db
        .into(_db.actions)
        .insert(
          ActionsCompanion.insert(
            name: name,
            description: Value(description),
            categoryId: Value(categoryId),
          ),
        );
    return await getAction(actionId);
  }

  Future<Action> getAction(int id) async {
    return await _db.managers.actions
        .filter((t) => t.id.equals(id))
        .getSingle();
  }

  Future<List<Action>> getActions() async {
    return await _db.select(_db.actions).get();
  }
}
