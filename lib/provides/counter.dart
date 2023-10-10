import 'package:flutter/cupertino.dart';

class counterState {
  int _value = 0;

  void inc() => _value++;

  void dec() => _value--;

  int get value => _value;
}

class ConterProvider extends InheritedWidget {
  final counterState state = counterState();

  ConterProvider({
    super.key,
    required Widget child,
  }) : super(child: child);

  static ConterProvider of(BuildContext context) {
    final ConterProvider? result =
        context.dependOnInheritedWidgetOfExactType<ConterProvider>();
    assert(result != null, 'No ConterProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ConterProvider old) {
    return true;
  }
}
