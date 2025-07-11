// ignore_for_file: constant_identifier_names

import 'package:weather_forecast/core/master_config.dart';

class EndPoint {
  EndPoint._();

  ///
  /// API URL
  /// Change your backend url
  ///

  static const String baseUrl = "https://api.openweathermap.org/data/2.5";
  static const String weatherByCity =
      "$baseUrl/weather?appid=${MasterConfig.apiKey}";
  static const String hourlyForecast =
      '$baseUrl/forecast?appid=${MasterConfig.apiKey}';
}
