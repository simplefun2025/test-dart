import 'package:happy_100/domain/dtos/action.dart';
import 'package:happy_100/domain/dtos/category.dart';
import 'package:happy_100/domain/dtos/record.dart';
import 'package:test/test.dart';

void main() {
  late List<Action> actionList;
  late Category category;
  late List<Record> recordList;

  setUp(() {
    actionList = [
      Action(
        id: 1,
        title: 'test',
        desc: 'test',
        imageUrl: 'test',
        category: 'test',
        type: 1,
      ),
      Action(
        id: 2,
        title: 'test2',
        desc: 'test2',
        imageUrl: 'test2',
        category: 'test2',
        type: 1,
      ),
      Action(
        id: 3,
        title: 'test3',
        desc: 'test3',
        imageUrl: 'test3',
        category: 'test2',
        type: 2,
      ),
    ];

    category = Category(id: 2, name: 'test2', actions: [...actionList]);

    recordList = [];
  });
  group('01. 행동 실행', () {
    test('01) 카테고리 랜덤 행동 선택', () {
      var selectedAction = category.randomAction;
      expect(
        category.actions.any((action) {
          return action == selectedAction;
        }),
        true,
      );
    });

    test('02) 행동 type 선택', () {
      var selectedAction = category.randomAction;
      expect(selectedAction.type != 0, true);
    });

    test('03) 행동 완료 시 기록 저장', () {
      var selectedAction = category.randomAction;
      var record = Record(
        actionId: selectedAction.id,
        id: 1,
        action: selectedAction,
        result: 1,
        date: DateTime.now(),
      );

      recordList.add(record);

      var recordResult = recordList[0];
      expect(recordResult.action, selectedAction);
      expect(recordResult.actionId, selectedAction.id);
    });
  });
}
