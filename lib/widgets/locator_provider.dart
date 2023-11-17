import 'package:flutter/widgets.dart';

import '../rx_flow.dart';

class LocatorProvider extends InheritedWidget {
  final Locator locator;

  const LocatorProvider({
    required this.locator,
    super.key,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static Locator of(BuildContext context) {
    var provider =
        context.dependOnInheritedWidgetOfExactType<LocatorProvider>();

    return provider!.locator;
  }
}
