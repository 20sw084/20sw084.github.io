import 'package:flutter/material.dart';
import 'package:my_portfolio/core/layout/adaptive.dart';
import 'package:my_portfolio/values/values.dart';

class ContentWrapper extends StatelessWidget {
  const ContentWrapper({
    super.key,
    this.width,
    this.height,
    this.color = AppColors.grey100,
    this.gradient,
    this.child,
  });

  final double? width;
  final double? height;
  final Color color;
  final Gradient? gradient;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? widthOfScreen(context),
      height: height ?? heightOfScreen(context),
      decoration: BoxDecoration(color: color, gradient: gradient),
      child: child,
    );
  }
}
