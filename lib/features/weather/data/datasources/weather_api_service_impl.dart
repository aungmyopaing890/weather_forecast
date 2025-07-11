import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/config/end_point/end_point.dart';
import 'package:weather_forecast/features/weather/data/model/hourly_weather_model.dart';
import 'package:weather_forecast/features/weather/data/model/weather_model.dart';
import 'package:weather_forecast/features/weather/domain/data_sources/weather_api_service.dart';
import 'package:weather_forecast/features/weather/domain/entity/hourly_weather_entity.dart';

class WeatherApiServiceImpl extends WeatherApiService {
  final http.Client client;

  WeatherApiServiceImpl({http.Client? client})
      : client = client ?? http.Client();

  @override
  Future<WeatherModel> fetchWeather(String city) async {
    final url = Uri.parse('${EndPoint.weatherByCity}&q=$city');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['cod'] == 200) {
        return WeatherModel.fromJson(data);
      } else {
        throw Exception('City not found');
      }
    } else {
      throw Exception('City not found or API error');
    }
  }

  @override
  Future<List<HourlyWeatherEntity>> fetchHourlyWeather(String city) async {
    final url = Uri.parse("${EndPoint.hourlyForecast}&q=$city");
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['cod'] == "200") {
        return (data['list'] as List)
            .map((e) => HourlyWeatherModel.fromJson(e))
            .take(8)
            .toList();
      } else {
        throw Exception('City not found');
      }
    } else {
      throw Exception('City not found or API error');
    }
  }
}
