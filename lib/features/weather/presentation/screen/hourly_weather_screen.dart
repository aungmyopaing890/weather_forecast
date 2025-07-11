import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/core/master_colors.dart';
import 'package:weather_forecast/core/setup_locator.dart';
import 'package:weather_forecast/features/common/custom_appbar.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/event/hourly_weather_event.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/hourly_weather_bloc.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';
import 'package:weather_forecast/features/weather/presentation/widget/hourly_weather/hourly_weather_list_view.dart';
import 'package:weather_forecast/features/weather/presentation/widget/hourly_weather/temperature_unit_switch.dart';

class HourlyWeatherScreen extends StatelessWidget {
  const HourlyWeatherScreen({
    super.key,
    required this.city,
    this.bloc,
    this.temperatureUnitCubit,
  });
  final String city;
  final HourlyWeatherBloc? bloc;
  final TemperatureUnitCubit? temperatureUnitCubit;

  String _capitalize(String input) {
    if (input.isEmpty) return '';
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HourlyWeatherBloc>(
          create: (_) => bloc ?? locator<HourlyWeatherBloc>()
            ..add(FetchHourlyWeather(city: city)),
        ),
      ],
      child: Scaffold(
        backgroundColor: MasterColors.background,
        appBar: CustomAppbar(
          title: '${_capitalize(city)} 24-Hour Forecast',
          fontSize: 16,
          actions: [
            TemperatureUnitSwitch(),
            const SizedBox(width: 16),
          ],
        ),
        body: HourlyWeatherListView(),
      ),
    );
  }
}
