import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/layout/adaptive.dart';
import 'package:my_portfolio/core/utils/functions.dart';
import 'package:my_portfolio/presentation/widgets/circular_container.dart';
import 'package:my_portfolio/presentation/widgets/socials.dart';
import 'package:my_portfolio/presentation/widgets/spaces.dart';
import 'package:my_portfolio/values/values.dart';

import 'menu_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.menuList,
    this.color = AppColors.secondaryColor,
    this.width,
    this.selectedItemRouteName,
    this.onClose,
  });

  final Color color;
  final double? width;
  final String? selectedItemRouteName;
  final List<MenuData> menuList;
  final GestureTapCallback? onClose;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      color: color,
      width: width ??
          assignWidth(
            context: context,
            fraction: 0.65,
          ), //widthOfScreen(context),
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(Sizes.PADDING_16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: onClose ??
                        () {
                          Navigator.pop(context);
                        },
                    child: const CircularContainer(
                      color: AppColors.accentColor2,
                      width: Sizes.WIDTH_30,
                      height: Sizes.HEIGHT_30,
                      child: Icon(
                        Icons.close,
                        size: Sizes.ICON_SIZE_20,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ..._buildMenuList(menuList: menuList, context: context),
              ],
            ),
            const Spacer(flex: 1),
            const Socials(
              isHorizontal: true,
              color: AppColors.accentColor2,
              alignment: Alignment.center,
              barColor: AppColors.accentColor2,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            const SpaceH16(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringConst.DESIGNED_IN,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: AppColors.accentColor2,
                    fontSize: Sizes.TEXT_SIZE_10,
                  ),
                ),
                const SpaceW4(),
                const Icon(
                  FontAwesomeIcons.solidHeart,
                  color: Colors.red,
                  size: Sizes.ICON_SIZE_10,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${StringConst.BUILT_BY}, ${StringConst.DESIGNED_BY}",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: AppColors.accentColor2,
                    fontSize: Sizes.TEXT_SIZE_10,
                  ),
                ),
              ],
            ),
            const SpaceH16(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuList({
    required BuildContext context,
    required List<MenuData> menuList,
  }) {
    List<Widget> menuItems = [];
    for (var i = 0; i < menuList.length; i++) {
      menuItems.add(
        MenuItem(
          onTap: () {
            if (menuList[i].title == StringConst.RESUME) {
              Functions.launchUrl(DocumentPath.CV);
            } else if (menuList[i].title == StringConst.CONTACT) {
              Functions.launchUrl(StringConst.EMAIL_URL);
            } else {
              Navigator.of(context).pushNamed(menuList[i].routeName);
            }
          },
          title: menuList[i].title,
          isMobile: true,
          selected:
              selectedItemRouteName == menuList[i].routeName ? true : false,
        ),
      );
      menuItems.add(const SpaceH16());
    }
    return menuItems;
  }
}
