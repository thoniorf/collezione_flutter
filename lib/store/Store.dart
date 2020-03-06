import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collezione/model/Stones.dart';

class Store {
  static Store store;
  static Stones stone;
  static Firestore _instance = Firestore.instance;

  static Store getInstance() {
    if(store == null) {
      store = new Store._();
    }
    return store;
  }

  Store._();

  static Stones getNewStone() {
    stone = new Stones();
    return stone;
  }

  static Future saveStone(){
    return _instance.collection("stones").document().setData(stone.parameters);
  }

}