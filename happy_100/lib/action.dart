class Action {
  final int id;
  final String category;
  final String title;
  final String desc;
  final String imageUrl;

  Action({
    required this.id,
    required this.category,
    required this.title,
    required this.desc,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Action &&
        other.id == id &&
        other.category == category &&
        other.title == title &&
        other.desc == desc &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return Object.hash(id, category, title, desc, imageUrl);
  }
}
