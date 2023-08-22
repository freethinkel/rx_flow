import 'package:get_it/get_it.dart';

class Locator {
  final GetIt _getIt = GetIt.asNewInstance();
  static final instance = Locator._();

  Locator._();

  Locator register<T extends Object>(T instance) {
    _getIt.registerSingleton(instance);

    return this;
  }

  T get<T extends Object>() {
    return _getIt.get<T>();
  }

  Future<void> reset() async {
    await _getIt.reset();
  }
}
