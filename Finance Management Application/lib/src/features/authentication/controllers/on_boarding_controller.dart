import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_string.dart';
import '../models/model_on_boarding.dart';
import '../screens/on_boarding/on_boarding_page_widget.dart';

class OnBoardingController extends GetxController{

  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: OnBoardingImage1,
        title: OnBoardingTitle1,
        subtitle: OnBoardingSubTitle1,
        counterText: OnBoardingCounter1,
        bgColor: OnBoardingPage1Color,
      ),
    ),

    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: OnBoardingImage2,
        title: OnBoardingTitle2,
        subtitle: OnBoardingSubTitle2,
        counterText: OnBoardingCounter2,
        bgColor: OnBoardingPage2Color,
      ),
    ),

    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: OnBoardingImage3,
        title: OnBoardingTitle3,
        subtitle: OnBoardingSubTitle3,
        counterText: OnBoardingCounter3,
        bgColor: OnBoardingPage3Color,
      ),
    ),
  ];

  skip() => controller.jumpToPage(page: 2);

  animateToNextSlide(){
    int nextPage = controller.currentPage +1;
    controller.animateToPage(page: nextPage);
  }
  onPageChangeCallback(int activePageIndex) => currentPage.value = activePageIndex;
}