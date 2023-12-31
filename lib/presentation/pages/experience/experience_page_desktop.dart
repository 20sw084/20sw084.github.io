import 'package:flutter/material.dart';
import 'package:my_portfolio/core/layout/adaptive.dart';
import 'package:my_portfolio/presentation/pages/experience/experience_page.dart';
import 'package:my_portfolio/presentation/widgets/content_wrapper.dart';
import 'package:my_portfolio/presentation/widgets/customer_scroller.dart';
import 'package:my_portfolio/presentation/widgets/experience_tree.dart';
import 'package:my_portfolio/presentation/widgets/menu_list.dart';
import 'package:my_portfolio/presentation/widgets/trailing_info.dart';
import 'package:my_portfolio/values/values.dart';

class ExperiencePageDesktop extends StatefulWidget {
  const ExperiencePageDesktop({super.key});

  @override
  _ExperiencePageDesktopState createState() => _ExperiencePageDesktopState();
}

class _ExperiencePageDesktopState extends State<ExperiencePageDesktop> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            ContentWrapper(
              width: assignWidth(
                context: context,
                fraction: 0.2,
              ),
              color: AppColors.primaryColor,
//                gradient: Gradients.primaryGradient,
              child: Container(
                margin: const EdgeInsets.only(
                  left: Sizes.MARGIN_20,
                  top: Sizes.MARGIN_20,
                  bottom: Sizes.MARGIN_20,
                ),
                child: MenuList(
                  menuList: Data.menuList,
                  selectedItemRouteName: ExperiencePage.experiencePageRoute,
                ),
              ),
            ),
            ContentWrapper(
              width: assignWidth(
                context: context,
                fraction: 0.8,
              ),
              color: AppColors.secondaryColor,
              child: Row(
                children: [
                  Container(
                    width: assignWidth(
                      context: context,
                      fraction: 0.7,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          assignWidth(context: context, fraction: 0.04),
                      vertical:
                          assignHeight(context: context, fraction: 0.04),
                    ),
                    child: _buildExperience(),
                  ),
                  SizedBox(
                    width: assignWidth(
                      context: context,
                      fraction: 0.025,
                    ),
                  ),
                  TrailingInfo(
                    width: assignWidth(
                      context: context,
                      fraction: 0.075,
                    ),
                    trailingWidget: CustomScroller(
                      onUpTap: () {
                        _scroll(_scrollController.position.minScrollExtent);
                      },
                      onDownTap: () {
                        _scroll(_scrollController.position.maxScrollExtent);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildExperience() {
    return ExperienceTree(
      headTitle: StringConst.CURRENT_MONTH_YEAR,
      tailTitle: StringConst.STARTED_MONTH_YEAR,
      experienceData: Data.experienceData,
      scrollController: _scrollController,
      widthOfTree: assignWidth(context: context, fraction: 0.62),
    );
  }

  _scroll(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}
