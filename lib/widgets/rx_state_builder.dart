import 'package:flutter/widgets.dart';
import 'package:rx_flow/model/rx.dart';

class RxStateBuilder<T> extends StatelessWidget {
  const RxStateBuilder({
    required this.state,
    required this.builder,
    super.key,
  });
  final RxState<T> state;

  final Widget Function(BuildContext, T?) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: state.stream,
      initialData: state.value,
      builder: (context, data) => builder(
        context,
        data.data ?? state.value,
      ),
    );
  }
}
