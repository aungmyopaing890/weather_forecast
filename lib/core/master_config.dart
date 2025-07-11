// ignore_for_file: constant_identifier_names

class MasterConfig {
  MasterConfig._();

  ///
  /// AppName

  static const String app_name = 'Weather Forecast';

  static const bool kDebugMode = true;

  ///
  /// AppVersion

  static const String app_version = '1.0.0';

  ///
  /// Border radious

  static const double borderRadious = 20;

  ///
  /// Is Server Direct
  ///

  static const bool isFullCache = true;
  static const String default_font_family = manrope_font_family;
  static const String manrope_font_family = 'Switzer';

  static double borderRadius = 10;
  static int shimmerCount = 10;

  static const double fullWidth = 380;
  static const double fullHeight = 820;

  static const String apiKey = '<your_api_key_here>';
}
