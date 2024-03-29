import 'package:flutter/widgets.dart';
import 'package:soiree/auth.dart';
import 'package:soiree/utils/messageProvider.dart';

class Provider extends InheritedWidget {
  final AuthService auth;
  MessageProvider messageProvider;
  Provider({
    required Key key,
    Widget? child,
    required this.auth, required this.messageProvider,
  }) : super(key: key, child: child!);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider? of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Provider>());
}
