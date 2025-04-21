import '../context/database.dart';

class ActionService {
  final AppDatabase _db;

  ActionService(this._db);

  Future<int> createAction({
    required String category,
    required String title,
    required String desc,
    required String imageUrl,
    required int type,
  }) async {
    final action = ActionsCompanion.insert(
      category: category,
      title: title,
      desc: desc,
      imageUrl: imageUrl,
      type: type,
    );

    return await _db.into(_db.actions).insert(action);
  }

  Future<Action?> getActionById(int id) async {
    final query = _db.select(_db.actions)..where((tbl) => tbl.id.equals(id));
    return await query.getSingleOrNull();
  }

  Future<List<Action>> getActionByIds(List<int> ids) async {
    final query = _db.select(_db.actions)..where((tbl) => tbl.id.isIn(ids));
    return await query.get();
  }
}
