import 'package:flutter/material.dart';

import '../../style/colors.dart';

class BaseFilledButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double pHeight;
  final double? pWidth;
  final Function()? onTap;
  final bool active;
  final Color enabledColor;
  final Color disabledColor;
  final Color? tapColor;
  final BorderRadius? borderRadius;
  final bool withoutCenter;
  final BoxShadow? boxShadow;
  final Border? border;

  const BaseFilledButton({
    Key? key,
    required this.child,
    this.padding,
    this.pHeight = 56,
    this.pWidth,
    this.onTap,
    this.active = true,
    required this.enabledColor,
    required this.disabledColor,
    this.tapColor,
    this.borderRadius,
    this.withoutCenter = false,
    this.boxShadow,
    this.border
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: pHeight,
      width: pWidth,
      decoration: BoxDecoration(
        color: active ? enabledColor : disabledColor,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow == null ? null : [
          boxShadow!,
        ]
      ),
      child: Material(
        color: active ? enabledColor : disabledColor,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: active ? onTap : null,
          highlightColor: tapColor,
          splashColor: tapColor,
          borderRadius: borderRadius,
          child: withoutCenter
              ? Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: child,
              )
              : Center(
                  child: Padding(
                  padding: padding ??
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: child,
                )),
        ),
      ),
    );
  }
}
