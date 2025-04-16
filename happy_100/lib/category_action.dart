import 'action.dart';

class CategoryAction extends Action {
  final int categoryId;

  CategoryAction({
    required super.id,
    required super.category,
    required super.title,
    required super.desc,
    required super.imageUrl,
    required this.categoryId,
    required super.type,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryAction &&
        other.categoryId == categoryId &&
        super == other;
  }

  @override
  int get hashCode {
    return Object.hash(super.hashCode, categoryId);
  }
}