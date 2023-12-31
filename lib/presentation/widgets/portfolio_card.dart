import 'package:flutter/material.dart';
import 'package:my_portfolio/presentation/widgets/spaces.dart';
import 'package:my_portfolio/presentation/widgets/horizontal_bar.dart';
import 'package:my_portfolio/values/values.dart';

class PortfolioCard extends StatefulWidget {
  const PortfolioCard({
    super.key,
    this.width = 500,
    this.height = 400,
    this.imageUrl,
    this.elevation,
    this.shadow,
    this.title,
    this.subtitle,
    this.actionTitle,
    this.hoverColor = AppColors.primaryColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.actionTitleTextStyle,
    this.duration = 1000,
    this.onTap,
  });

  final double width;
  final double height;
  final String? imageUrl;
  final double? elevation;
  final Shadow? shadow;
  final String? title;
  final String? subtitle;
  final String? actionTitle;
  final Color hoverColor;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final TextStyle? actionTitleTextStyle;
  final int duration;
  final GestureTapCallback? onTap;

  @override
  _PortfolioCardState createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard>
    with TickerProviderStateMixin {
  late AnimationController _portfolioCoverController;
  late Animation<double> _opacityAnimation;
  final int duration = 400;
  bool _hovering = false;

  @override
  void initState() {
    _portfolioCoverController = AnimationController(
      duration: Duration(milliseconds: duration),
      vsync: this,
    );
    initTweens();

    super.initState();
  }

  @override
  void dispose() {
    _portfolioCoverController.dispose();
    super.dispose();
  }

  void initTweens() {
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _portfolioCoverController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  Future<void> _playPortfolioCoverAnimation() async {
    try {
      await _portfolioCoverController.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: MouseRegion(
          onEnter: (e) => _mouseEnter(true),
          onExit: (e) => _mouseEnter(false),
          child: Stack(
            children: [
              Image.asset(
                widget.imageUrl!,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.cover,
              ),
              _hovering
                  ? FadeTransition(
                      opacity: _opacityAnimation,
                      child: Container(
                        width: widget.width,
                        height: widget.height,
                        color: widget.hoverColor,
                        child: Column(
                          children: [
                            const Spacer(flex: 1),
                            Text(
                              widget.title!,
                              textAlign: TextAlign.center,
                              style: widget.titleTextStyle ??
                                  theme.textTheme.headlineMedium!.copyWith(
                                    color: AppColors.secondaryColor,
                                  ),
                            ),
                            const SpaceH4(),
                            Text(
                              widget.subtitle!,
                              textAlign: TextAlign.center,
                              style: widget.subtitleTextStyle ??
                                  theme.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.secondaryColor,
                                      fontSize: Sizes.TEXT_SIZE_16),
                            ),
                            const SpaceH16(),
                            Text(
                              widget.actionTitleTextStyle as String? ?? widget.actionTitle!,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium!
                                  .copyWith(color: AppColors.secondaryColor),
                            ),
                            const SpaceH4(),
                            const HorizontalBar(color: AppColors.secondaryColor),
                            const Spacer(flex: 1),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _hovering = hovering;
    });

    if (_hovering == true) {
      _playPortfolioCoverAnimation();
    } else if (_hovering == false) {
      _portfolioCoverController.reverse().orCancel;
    }
  }
}
