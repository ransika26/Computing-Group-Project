import 'package:finanace_management_application/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:finanace_management_application/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:finanace_management_application/src/constants/colors.dart';
import 'package:finanace_management_application/src/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;

    return Scaffold(
        backgroundColor: isDarkMode ? SecondaryColor : PrimaryColor,
        body: Stack(
          children: [
            FadeinAnimation(
              durationInMs: 1200,
              animate: AnimatePosition(
                bottomAfter: 0,
                bottomBefore: -100,
                leftBefore: 0,
                leftAfter: 0,
                topAfter: 0,
                topBefore: 0,
                rightAfter: 0,
                rightBefore: 0,
              ),
              child: Container(
                padding: EdgeInsets.all(DefaultSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                        image: AssetImage(WelcomeScreenImage),
                        height: height * 0.5),
                    Column(
                      children: [
                        Text(
                          WelcomeTitle,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          WelcomeSubtitle,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(Login.toUpperCase()),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(Signup.toUpperCase()),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
