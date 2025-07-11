import 'package:flutter/material.dart';
import 'package:weather_forecast/config/router/custom_transition.dart';
import 'package:weather_forecast/config/router/route_paths.dart';
import 'package:weather_forecast/features/splash/presentation/splash_screen.dart';
import 'package:weather_forecast/features/weather/data/holder/city_intent_holder.dart';
import 'package:weather_forecast/features/weather/presentation/screen/hourly_weather_screen.dart';
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
    case RoutePaths.hourlyForecast:
      CityIntentHolder holder = settings.arguments as CityIntentHolder;
      return createSlideTransitionRoute(
        HourlyWeatherScreen(
          city: holder.city,
        ),
      );

    default:
      return createSlideTransitionRoute(
        const SizedBox(),
      );
  }
}
