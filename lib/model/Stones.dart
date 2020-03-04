import 'dart:collection';

class Stones {
  Map parameters;

  Stones() {
    create();
  }

  create() {
    parameters = new HashMap<String, String>();
  }

  put(String key, String value) {
    parameters[key] = value;
  }

  remove(String key) {
    parameters.remove(key);
  }
}
