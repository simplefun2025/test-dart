import 'dart:math';

import 'category_action.dart';
import 'action.dart';

class Category {
  final int id;
  final String name;
  List<CategoryAction> _actions = [];

  Category({
    required this.id,
    required this.name,
    required List<Action> actions,
  }) {
    this.actions = actions;
  }

  set actions(List<Action> actions) {
    _actions = actions.map((action) {
      return CategoryAction(
        id: action.id,
        category: action.category,
        title: action.title,
        desc: action.desc,
        imageUrl: action.imageUrl,
        categoryId: id,
      );
    }).toList();
  }

  List<CategoryAction> get actions {
    return _actions;
  }

  CategoryAction get randomAction {
    var random = Random();
    return _actions[random.nextInt(_actions.length)];
  }
}