mixin StateNotifier {
  List<Function> callbacks = [];

  void addCallback(Function callback) {
    callbacks.add(callback);
  }

  void notifyListeners() {
    for (var callback in callbacks) {
      callback();
    }
  }

  void removeCallback(Function callback) {
    callbacks.remove(callback);
  }
}
