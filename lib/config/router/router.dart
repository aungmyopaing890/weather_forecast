import 'package:flutter/material.dart';
import 'package:weather_forecast/config/router/custom_transition.dart';
import 'package:weather_forecast/features/splash/presentation/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const SplashScreen(),
      );

    default:
      return createSlideTransitionRoute(
        const SizedBox(),
      );
  }
}
