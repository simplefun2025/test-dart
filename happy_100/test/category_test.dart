import 'package:happy_100/data/models/actions.dart';
import 'package:happy_100/data/models/action.dart';
import 'package:happy_100/data/models/category.dart';
import 'package:test/test.dart';

void main() {
  late Actions actions;
  late List<Action> actionList;
  late List<Category> categories;

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

    actions = Actions(actions: actionList);

    categories = [
      Category(
        id: 1,
        name: 'test',
        actions: [
          Action(
            id: 1,
            title: 'test',
            desc: 'test',
            imageUrl: 'test',
            category: 'test',
            type: 1,
          ),
        ],
      ),
      Category(id: 2, name: 'test2', actions: [...actionList]),
    ];
  });

  group('01. 카테고리 생성', () {
    test('01) 행동 목록 조회', () {
      var selectActions = actions.select();
      expect(selectActions.length, 3);
      expect(selectActions[0].id, 1);
      expect(selectActions[0].title, 'test');
      expect(selectActions[0].desc, 'test');
      expect(selectActions[0].imageUrl, 'test');
      expect(selectActions[0].category, 'test');
    });

    test('02) 카테고리 생성', () {
      var selectActions = actions.select(category: 'test2');
      expect(selectActions.length, 2);
      expect(selectActions[0].id, 2);

      var category = Category(id: 1, name: 'test', actions: selectActions);

      expect(category.id, 1);
      expect(category.name, 'test');
      expect(category.actions.length, 2);
      expect(category.actions[0].categoryId, 1);
      expect(category.actions[0].id, 2);
    });
  });

  group('02. 카테고리 수정', () {
    test('01) 카테고리 조회 및 상세내용 조회', () {
      var category = categories[1];
      expect(category.id, 2);
      expect(category.name, 'test2');
      expect(category.actions.length, 3);
      expect(category.actions[0].id, 1);
      expect(category.actions[0].categoryId, 2);
      expect(category.actions[0].title, 'test');
      expect(category.actions[1].id, 2);
      expect(category.actions[1].categoryId, 2);
      expect(category.actions[1].title, 'test2');
      expect(category.actions[2].id, 3);
      expect(category.actions[2].categoryId, 2);
      expect(category.actions[2].title, 'test3');
    });

    test('02) 카테고리 2번 Actions test2 카테고리 목록으로 수정', () {
      var category = categories[1];

      var selectActions = actions.select(category: 'test2');
      category.actions = selectActions;

      expect(category.actions.length, 2);
      expect(category.actions[0].id, 2);
      expect(category.actions[0].categoryId, 2);
      expect(category.actions[0].category, 'test2');
      expect(category.actions[1].category, 'test2');
    });
  });
}
