import 'package:flutter/material.dart';
import 'package:my_portfolio/core/layout/adaptive.dart';
import 'package:my_portfolio/core/utils/functions.dart';
import 'package:my_portfolio/presentation/pages/portfolio/portfolio_page.dart';
import 'package:my_portfolio/presentation/widgets/app_drawer.dart';
import 'package:my_portfolio/presentation/widgets/circular_container.dart';
import 'package:my_portfolio/presentation/widgets/content_wrapper.dart';
import 'package:my_portfolio/presentation/widgets/socials.dart';
import 'package:my_portfolio/presentation/widgets/spaces.dart';
import 'package:my_portfolio/values/values.dart';

import 'home_page.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  _HomePageMobileState createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        menuList: Data.menuList,
        selectedItemRouteName: HomePage.homePageRoute,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  ContentWrapper(
                    width: assignWidth(context: context, fraction: 0.8),
                    color: AppColors.primaryColor,
//                        gradient: Gradients.primaryGradient,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: assignHeight(
                            context: context,
                            fraction: 0.2,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: ListBody(
                            children: [
                              Text(
                                StringConst.DEV_NAME,
                                style: theme.textTheme.headlineMedium!.copyWith(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              const SpaceH8(),
                              Text(
                                StringConst.SPECIALITY,
                                style: theme.textTheme.titleLarge!.copyWith(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(flex: 1),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PortfolioPage.portfolioPageRoute,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Column(
                              children: [
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    StringConst.VIEW_PORTFOLIO,
                                    textAlign: TextAlign.end,
                                    style:
                                        theme.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.secondaryColor,
                                      fontSize: Sizes.TEXT_SIZE_18,
                                    ),
                                  ),
                                ),
                                const SpaceH12(),
                                const CircularContainer(
                                  width: Sizes.WIDTH_24,
                                  height: Sizes.HEIGHT_24,
                                  color: AppColors.secondaryColor,
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: assignHeight(
                            context: context,
                            fraction: 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ContentWrapper(
                    width: assignWidth(context: context, fraction: 0.2),
                    color: AppColors.secondaryColor,
                    child: Container(),
                  ),
                ],
              )
            ],
          ),
          _buildAppBar(),
          _buildDevImage(),
          _buildSocials(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.PADDING_16,
        vertical: Sizes.PADDING_16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              if (_scaffoldKey.currentState!.isEndDrawerOpen) {
                _scaffoldKey.currentState!.openEndDrawer();
              } else {
                _scaffoldKey.currentState!.openDrawer();
              }
            },
            icon: const Icon(Icons.menu),
          ),
          CircularContainer(
            color: AppColors.primaryColor,
            child: InkWell(
              onTap: () {
                Functions.launchUrl(StringConst.EMAIL_URL);
//                Navigator.pushNamed(
//                  context,
//                  ContactPage.contactPageRoute,
//                );
              },
              child: const Icon(
                Icons.email,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDevImage() {
    return Positioned(
      top: 56,
      right: -assignWidth(context: context, fraction: 0.42),
      child: Image.asset(
        ImagePath.DEV,
        height: assignHeight(context: context, fraction: 1),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSocials() {
    return const Positioned(
      right: Sizes.SIZE_16,
      bottom: Sizes.SIZE_30,
      child: Socials(
        isVertical: true,
        alignment: Alignment.centerRight,
        color: AppColors.secondaryColor,
        barColor: AppColors.secondaryColor,
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
    );
  }
}
