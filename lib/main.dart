// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:weather_forecast/config/router/router.dart';
import 'package:weather_forecast/core/master_config.dart';
import 'package:weather_forecast/core/navigator_config.dart';
import 'package:weather_forecast/core/setup_locator.dart';
import 'package:weather_forecast/core/themes/master_theme_data.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  await setupLocator();
  await Future.delayed(const Duration(milliseconds: 300));
  runApp(
    MainApp(),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _AppState();
}

class _AppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ThemeManager(
      defaultBrightnessPreference: BrightnessPreference.light,
      data: (Brightness brightness) {
        if (brightness == Brightness.light) {
          return themeData(
            ThemeData.light(),
          );
        } else {
          return themeData(
            ThemeData.dark(),
          );
        }
      },
      themeChangeListener: (ThemeState state) {
        debugPrint('ThemeState: ${state.brightnessPreference}');
      },
      themedBuilder: (BuildContext context, ThemeState state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<TemperatureUnitCubit>(
              create: (_) => locator<TemperatureUnitCubit>(),
            ),
          ],
          child: MaterialApp(
            navigatorKey: NavigatorConfig.getNavigatorKey(),
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            onGenerateRoute: generateRoute,
            initialRoute: '/',
            title: MasterConfig.app_name,
          ),
        );
      },
    );
  }
}
