import 'action.dart';

class Record {
  final int id;
  final int actionId;
  final int result;
  final DateTime date;
  final Action action;

  Record({
    required this.id,
    required this.actionId,
    required this.result,
    required this.date,
    required this.action,
  });
}
