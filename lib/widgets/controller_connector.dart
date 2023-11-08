import 'package:flutter/widgets.dart';
import 'package:rx_flow/model/controller.dart';
import 'package:rx_flow/widgets/locator_provider.dart';

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

  static C of<C extends IController>(BuildContext context) {
    return LocatorProvider.of(context).get<C>();
  }
}

class _ControllerConnectorState<C extends IController>
    extends State<ControllerConnector<C>> {
  late final C controller = ControllerConnector.of(context);

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
