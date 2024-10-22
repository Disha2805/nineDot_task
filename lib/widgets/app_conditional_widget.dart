import 'package:flutter/material.dart';


///Show Replacement
class If extends StatelessWidget {
  const If({
    super.key,
    required this.condition,
    required this.child,
    this.replacement,
  });

  final bool condition;
  final WidgetBuilder child;
  final WidgetBuilder? replacement;

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return child(context);
    } else {
      return replacement?.call(context) ?? const SizedBox.shrink();
    }
  }

}
