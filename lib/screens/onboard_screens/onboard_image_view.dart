import 'package:expense_tracker/helper/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/dot_indicator.dart';

class OnBoardImageView extends StatefulWidget {
  const OnBoardImageView({super.key});

  @override
  State<OnBoardImageView> createState() => _OnBoardImageViewState();
}

class _OnBoardImageViewState extends State<OnBoardImageView> {
  int currentIndex = 0;
  List<Map<String, dynamic>> slides = [
    {
      "name": "Gain total control of your money",
      "image": StringRes.onBoardIcon1,
      "description": "Become your own money manager and make every cent count"
    },
    {
      "name": "Know where your money goes",
      "image": StringRes.onBoardIcon2,
      "description":
          "Track your transaction easily, with categories and financial report "
    },
    {
      "name": "Planning ahead",
      "image": StringRes.onBoardIcon3,
      "description": "Setup your budget for each category so you in control"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  return Slider(
                    image: slides[index]["image"],
                    title: slides[index]["name"],
                    description: slides[index]["description"],
                  );
                }),
          ),
        ),
        DotsIndicator(
          dotsCount: slides.length,
          position: currentIndex.toDouble(),
          decorator: const DotsDecorator(
            spacing: EdgeInsets.symmetric(horizontal: 8),
            size: Size.square(10.0),
            activeSize: Size.square(16.0),
            color: AppColors.secondButtonColor,
            // Inactive color
            activeColor: AppColors.buttonColor,
          ),
        ),
      ],
    );
  }
}

class Slider extends StatelessWidget {
  final String image, title, description;

  const Slider({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Image(image: AssetImage(image))),
          SizedBox(height: 4.h),
          Text(title,
              style: TextStyle(
                fontSize:
                    Device.screenType == ScreenType.tablet ? 15.sp : 25.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center),
          SizedBox(height: 2.h),
          Text(description,
              style: TextStyle(
                  fontSize:
                      Device.screenType == ScreenType.tablet ? 8.sp : 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF91919F)),
              textAlign: TextAlign.center),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
