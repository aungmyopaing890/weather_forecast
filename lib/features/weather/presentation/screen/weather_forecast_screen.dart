// presentation/weather_forecast_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/core/master_colors.dart';
import 'package:weather_forecast/core/setup_locator.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/weather_bloc.dart';
import 'package:weather_forecast/features/weather/presentation/widget/weather/get_weather_buttom.dart';
import 'package:weather_forecast/features/weather/presentation/widget/weather/weather_data_widget.dart';
import 'package:weather_forecast/features/weather/presentation/widget/weather/weather_text_field.dart';
import 'package:weather_forecast/features/weather/presentation/widget/weather/weather_title_and_info.dart';

class WeatherForecastScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  WeatherForecastScreen({super.key, this.viewModel});
  final WeatherBloc? viewModel;

  @override
  Widget build(BuildContext context) {
    final vm = viewModel ?? locator<WeatherBloc>();
    return BlocProvider(
      create: (_) => vm,
      child: Scaffold(
        backgroundColor: MasterColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const WeatherTitleAndInfo(),
                WeatherTextField(controller: _controller),
                GetWeatherButtom(controller: _controller),
                const WeatherDataWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
