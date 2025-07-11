import 'package:flutter/material.dart';
import 'package:weather_forecast/config/router/route_paths.dart';
import 'package:weather_forecast/core/master_colors.dart';
import 'package:weather_forecast/core/master_config.dart';
import 'package:weather_forecast/core/navigator_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    debugPrint("SplashView initState");
    super.initState();

    _navigateToHome();
  }

  void _gotoRoute(String route) {
    Navigator.of(NavigatorConfig.getNavigatorKey().currentContext!)
        .pushNamedAndRemoveUntil(
      route,
      (Route<dynamic> route) => false,
    );
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      _gotoRoute(RoutePaths.weatherForecast);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasterColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 10),
            Text(
              MasterConfig.app_name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              color: MasterColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
