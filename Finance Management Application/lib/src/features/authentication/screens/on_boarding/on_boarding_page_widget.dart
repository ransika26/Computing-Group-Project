import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_string.dart';
import '../../models/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(DefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(model.image), height: size.height * 0.4,),
          Column(
            children: [
              Text(OnBoardingTitle1, style: Theme.of(context).textTheme.headlineMedium,),
              Text(OnBoardingSubTitle1, textAlign: TextAlign.center,),
            ],
          ),
          Text(OnBoardingCounter1, style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: 80.0,),
        ],
      ),
    );
  }
}