import 'package:finanace_management_application/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:finanace_management_application/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:finanace_management_application/src/constants/colors.dart';
import 'package:finanace_management_application/src/constants/image_strings.dart';
import 'package:finanace_management_application/src/constants/sizes.dart';
import 'package:finanace_management_application/src/constants/text_string.dart';
import 'package:finanace_management_application/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      body: Stack(
        children: [
          FadeinAnimation(
          durationInMs: 1600,
          animate: AnimatePosition(
          topAfter: 150, topBefore: 0,
        ),
        child: const Image(image: AssetImage(SplashImage)),
      ),

      FadeinAnimation(
              durationInMs: 2000,
              animate: AnimatePosition(topBefore: 80, topAfter: 80, leftAfter: DefaultSize, leftBefore: -80),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppName, style: Theme.of(context).textTheme.headlineMedium,),
                      Text(AppTagLine, style: Theme.of(context).textTheme.headlineSmall,),
                    ],
                  ),
                ),
              ],
              ),
            );

  }
}

