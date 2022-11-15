import 'package:cointrack2/model/entity.dart';

class EntityRepo {
  List entities = <Entity>[];

  EntityRepo() {
    add(Entity(1, 'Cumparaturi Lidl', 'groceries', 3, 'cumparaturi periodice de baza', DateTime.now()));
    add(Entity(2, 'Chirie', 'housing', 3, '', DateTime.now()));
    add(Entity(3, 'Pizza Hut', 'leisure', 3, 'Peperoni', DateTime.now()));
  }

  void add(Entity entity) {
    entities.add(entity);
  }

  void update(Entity entity, int position) {
    entities[position] = entity;
  }

  EntityRepo getList() {
    return this;
  }
}
