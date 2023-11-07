# RxFlow

state manager with rxdart

This package provides:

- RxDart
- GetIt (dependency injection)
- SharedPreferences (persistent store)

## how to use

```dart
abstract class IUserController extends IController {
  RxState<UserData> userData$;
}

class UserControllerImpl extends IController {...}

Locator.global.register<IUserController>(UserControllerImpl);

class MyWidget extends RxConsumer {
  @override
  Widget build(BuildContext context, watcher) {
    final userController = watcher.controller<IUserController>();
    final userData = watcher.watch(userController.userData$)

    return ...
  }
}

```
