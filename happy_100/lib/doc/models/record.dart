class Record {
  final int id;
  final int actionId;
  final int? memoId;
  final DateTime date;

  Record({
    required this.id,
    required this.actionId,
    this.memoId,
    required this.date,
  });
}
