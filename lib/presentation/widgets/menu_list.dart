import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/utils/functions.dart';
import 'package:my_portfolio/presentation/widgets/menu_item.dart';
import 'package:my_portfolio/presentation/widgets/socials.dart';
import 'package:my_portfolio/presentation/widgets/spaces.dart';
import 'package:my_portfolio/values/values.dart';

class MenuList extends StatelessWidget {
  const MenuList({
    super.key,
    required this.menuList,
    this.selectedItemRouteName,
  });

  final List<MenuData> menuList;
  final String? selectedItemRouteName;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ..._buildMenuList(menuList: menuList, context: context),
        const Spacer(
          flex: 1,
        ),
        const Socials(
          isVertical: true,
          alignment: Alignment.centerLeft,
          color: AppColors.secondaryColor,
          barColor: AppColors.secondaryColor,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        const Spacer(
          flex: 1,
        ),
        Text(
          StringConst.DEV_NAME,
          style: theme.textTheme.headlineMedium!.copyWith(
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          StringConst.SPECIALITY,
          style: theme.textTheme.titleLarge!.copyWith(
            color: AppColors.secondaryColor,
          ),
        ),
        const SpaceH20(),
        Row(
          children: [
            Text(
              StringConst.DESIGNED_IN,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: AppColors.secondaryColor,
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
        Wrap(
          children: [
            Text(
              "${StringConst.BUILT_BY}, ${StringConst.DESIGNED_BY}",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: AppColors.secondaryColor,
                fontSize: Sizes.TEXT_SIZE_10,
              ),
            ),
          ],
        ),
      ],
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
          selected:
              selectedItemRouteName == menuList[i].routeName ? true : false,
        ),
      );
      menuItems.add(const SpaceH4());
    }
    return menuItems;
  }
}
