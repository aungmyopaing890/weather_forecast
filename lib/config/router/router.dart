import 'package:flutter/material.dart';
import 'package:weather_forecast/config/router/custom_transition.dart';
import 'package:weather_forecast/config/router/route_paths.dart';
import 'package:weather_forecast/features/splash/presentation/splash_screen.dart';
import 'package:weather_forecast/features/weather/presentation/screen/weather_forecast_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const SplashScreen(),
      );

    case RoutePaths.weatherForecast:
      return createSlideTransitionRoute(
        WeatherForecastScreen(),
      );

    default:
      return createSlideTransitionRoute(
        const SizedBox(),
      );
  }
}
