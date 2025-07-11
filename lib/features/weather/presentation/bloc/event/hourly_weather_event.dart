abstract class HourlyWeatherEvent {
  const HourlyWeatherEvent();
}

class FetchHourlyWeather extends HourlyWeatherEvent {
  final String city;

  const FetchHourlyWeather({
    required this.city,
  });
}
