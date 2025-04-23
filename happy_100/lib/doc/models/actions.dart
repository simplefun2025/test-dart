import 'action.dart';

class Actions {
  final List<Action> actions;

  Actions({required this.actions});

  List<Action> select({String? category}) {
    return actions
        .where((action) => action.category == (category ?? action.category))
        .toList();
  }
}
