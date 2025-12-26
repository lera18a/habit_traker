import 'package:flutter/material.dart';

class GreyContainer extends StatelessWidget {
  const GreyContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 15,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final content = padding != null
        ? Padding(padding: padding!, child: child)
        : child;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color ?? Colors.grey[300],
      ),
      child: content,
    );
  }
}
