import 'package:flutter/material.dart';
import 'package:my_portfolio/presentation/pages/about/about_page_desktop.dart';
import 'package:my_portfolio/presentation/pages/about/about_page_mobile.dart';
import 'package:my_portfolio/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';

//TODO:: Add bottomBar to about page
class AboutPage extends StatelessWidget {
  static const String aboutPageRoute = StringConst.ABOUT_PAGE;

  const AboutPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout(
        mobile: const AboutPageMobile(),
        tablet: const AboutPageDesktop(),
        desktop: const AboutPageDesktop(),
      ),
    );
  }
}
