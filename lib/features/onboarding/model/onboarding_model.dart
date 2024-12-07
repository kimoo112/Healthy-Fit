import '../../../../core/utils/app_assets.dart';

class OnBoardingModel {
  final String imagePath;
  final String subTitle;
  final String title;

  OnBoardingModel({
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });
}

final List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    title: 'Welcome To Healthy Fit',
    subTitle: 'Your personal assistant for a healthier, balanced lifestyle.',
    imagePath: Assets.imagesOnboarding1,
  ),
  OnBoardingModel(
    title: 'Track Your Calories with Ease',
    subTitle: 'We will help you lose weight, stay fit, or build muscle',
    imagePath: Assets.imagesOnboarding2,
  ),
  OnBoardingModel(
    title: 'Live Healthy & Great',
    subTitle: 'Let’s start this journey and live healthy together!',
    imagePath: Assets.imagesOnboarding3,
  ),
];
