import 'package:collezione/model/Stones.dart';

class Store {
  static Store store;
  static Stones stone;

  static Store getInstance() {
    if(store == null) {
      store = new Store._();
    }
    return store;
  }

  Store._();

  static Stones getNewInstance() {
    stone = new Stones();
    return stone;
  }

}