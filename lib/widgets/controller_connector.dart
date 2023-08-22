import 'package:flutter/widgets.dart';
import 'package:rx_state/di/locator.dart';
import 'package:rx_state/model/controller.dart';

class ControllerConnector<C extends IController> extends StatefulWidget {
  const ControllerConnector({
    required this.builder,
    this.useWidgetGate = false,
    super.key,
  });

  final Widget Function(BuildContext, C controller) builder;
  final bool useWidgetGate;

  @override
  State<ControllerConnector<C>> createState() => _ControllerConnectorState<C>();

  static C of<C extends IController>() {
    return Locator.instance.get<C>();
  }
}

class _ControllerConnectorState<C extends IController>
    extends State<ControllerConnector<C>> {
  final C controller = Locator.instance.get();

  @override
  void initState() {
    if (widget.useWidgetGate) {
      controller.init();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.useWidgetGate) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller);
  }
}
