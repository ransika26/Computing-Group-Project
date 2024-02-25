import 'package:finanace_management_application/src/constants/colors.dart';
import 'package:finanace_management_application/src/constants/image_strings.dart';
import 'package:finanace_management_application/src/constants/text_string.dart';
import 'package:finanace_management_application/src/features/authentication/controllers/on_boarding_controller.dart';
import 'package:finanace_management_application/src/features/authentication/models/model_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/sizes.dart';
import 'on_boarding_page_widget.dart';

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final obcontroller = OnBoardingController();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
              pages: obcontroller.pages,
              enableSideReveal: true,
              liquidController: obcontroller.controller,
              onPageChangeCallback: obcontroller.onPageChangeCallback,
              slideIconWidget: const Icon(Icons.arrow_back_ios),
         ),
          Positioned(
            bottom: 60.0,
              child: OutlinedButton(
                onPressed: () => obcontroller.animateToNextSlide(),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.black26),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  onPrimary: Colors.white
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xff272727), shape: BoxShape.circle
                  ),
                  child: Icon(Icons.arrow_forward_ios),
                ),

            ),
          ),
          Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: () => obcontroller.skip(),
                child: const Text("Skip", style: TextStyle(color: Colors.grey),),
              ),
          ),
          Obx(
            () => Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                count: 3,
                activeIndex: obcontroller.currentPage.value,
                effect: const WormEffect(
                  activeDotColor: Color(0xff272727),
                  dotHeight: 5.0,
                ),

            ),
            ),
          ),
       ],
      )
    );
  }


}


