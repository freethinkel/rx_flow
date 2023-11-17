import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rx_flow/model/controller.dart';
import 'package:rx_flow/model/rx.dart';
import 'package:rx_flow/widgets/controller_connector.dart';

abstract class StateWatcher {
  C controller<C extends IController>();
  T? watch<T>(RxState<T> state);
}

class StateWatcherImpl implements StateWatcher {
  const StateWatcherImpl({
    required this.onRegisterState,
    required this.context,
  });
  final Function(RxState) onRegisterState;
  final MutBox<BuildContext> context;

  @override
  C controller<C extends IController>() {
    return ControllerConnector.of<C>(context.get());
  }

  @override
  T? watch<T>(RxState<T> state) {
    onRegisterState(state);
    return state.value;
  }
}

abstract class RxConsumer extends StatefulWidget {
  const RxConsumer({super.key});
  Widget build(BuildContext context, StateWatcher watcher);

  void onInit(BuildContext context) {}
  void dispose() {}

  @override
  // ignore: library_private_types_in_public_api
  _ConsumerState createState() => _ConsumerState();
}

class _ConsumerState extends State<RxConsumer> {
  final Set<RxState> _states = {};
  List<StreamSubscription> _subscriptions = [];
  late final watcher = StateWatcherImpl(
    onRegisterState: (state) {
      if (_states.contains(state)) {
        return;
      }
      _states.add(state);
      _onUpdate();
    },
    context: _mutContext,
  );
  late final _mutContext = MutBox(value: context);

  _onUpdate() {
    _unlisten();
    for (var state in _states) {
      _subscriptions.add(state.stream.listen((event) {
        setState(() {});
      }));
    }
  }

  void _unlisten() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions = [];
  }

  @override
  void initState() {
    widget.onInit(context);
    super.initState();
  }

  @override
  void dispose() {
    _unlisten();
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _mutContext.set(context);
    return widget.build(context, watcher);
  }
}

class MutBox<T> {
  MutBox({required T value}) : _value = value;
  T _value;

  T get() {
    return _value;
  }

  set(T value) {
    _value = value;
  }
}
